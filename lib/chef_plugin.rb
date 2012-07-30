require 'chef/rest'

module ChefPlugin

  class Runner
    def run_update(run_description)
      worklog = Worklog.create!(name: "Chef run #{run_description}", start: Time.now)
      Rails.logger.info "Starting chef run #{run_description} #{worklog}..."
      begin
        reader = ChefPlugin::Reader.new(worklog)
        reader.update
      rescue => e
        worklog.error = e.to_s
      end
      worklog.end = Time.now
      worklog.save!
      Rails.logger.info "...Finished #{run_description} run for chef job to read from chef #{worklog}"
    end
  end

  def self.url_for_node(n)
    "#{@chef_server}/nodes/#{n}"
  end

  class Reader
    def initialize(worklog)
      @worklog = worklog
      @settings = Setting.get
      @chef_server = @settings.chef_server
      @chef_user = @settings.chef_user
      @chef_pem_file = @settings.chef_pem_file
      @rest = Chef::REST.new(@chef_server, @chef_user, @chef_pem_file)
    end

    def update
      unless @settings.chef_enabled
        Rails.logger.info "Chef is disabled, will not sync now"
        @worklog.error = "Chef is disabled"
        return
      end
      nodes =  @rest.get_rest("/nodes")
      nodes.each do |k, v|
        update_node k
      end
    end

    def update_node(node_name)
      physical_host = PhysicalHost.find_by_name(node_name)
      if physical_host
        Rails.logger.info("Fetching chef data for #{node_name}")
        node = @rest.get_rest("/nodes/#{node_name}")
        json_attributes = as_json(node)
        if physical_host.chef_info
          physical_host.chef_info.apply_json(json_attributes)
        else
          physical_host.chef_info = ChefInfo.new(json_attributes)
        end
        if physical_host.chef_info.changed?
          audit = Audit.new(source: 'cron', action: 'update_chef')
          physical_host.audits << audit
          physical_host.save!
          @worklog.audits << audit
          @worklog.save!
        else
          Rails.logger.info "Nothing changed from chef for #{node_name}"
        end
      else
        Rails.logger.info("No onering node found for #{node_name}. Will not update chef data")
      end
    end

    # Removes some of the information from this node's info so that it can be safely stored
    def as_json(node)
      json = {
          name: node.name,
          ipaddress: node.ipaddress,
          domain: (node.domain if node.has_key?('domain')),
          os_version: node.os_version,
          recipes: (node.recipes.as_json if node.has_key?('recipes')),
          hostname: node.hostname,
          tags: node.tags.as_json,
        }
      if node.has_key?('network')
        network = {}
        network['default_interface'] = node.network.default_interface
        interfaces = {}
        node.network.interfaces.select{|k, v| k.start_with?('eth')}.each do |ifname, v|
          interface = {}
          if v['addresses']
            v['addresses'].each do |address, v|
              interface[v['family']] = address
            end
          end
          interfaces[ifname] = interface
        end
        network['interfaces'] = interfaces
        json['network'] = network
      end
      json
    end
  end
end