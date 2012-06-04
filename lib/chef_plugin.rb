require 'chef/rest'

module ChefPlugin
  def self.load_config
    YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'chef.yaml'))).result)
  end

  @config = load_config

  def self.url_for_node(n)
    "#{@config['chef_server']}/nodes/#{n}"
  end

  class Reader
    def initialize
      @config = ChefPlugin::load_config
      @rest = Chef::REST.new(@config['chef_server'], @config['username'], @config['pem_file'])
    end

    # Updates the roles of the hosts as seen by glu
    def update
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
          puts physical_host.chef_info.changes
          physical_host.audits << Audit.new(source: 'cron', action: 'update_chef')
          physical_host.save!
        else
          Rails.logger.info "Nothing changed from chef for #{node_name}"
        end
      else
        Rails.logger.info("No onering node found for #{node_name}. Will not update chef data")
      end
    end

    # Removes some of the information from this node's info so that it can be safely stored
    def as_json(node)
      {
        name: node.name,
        kernel_name: node.kernel.name,
        kernel_machine: node.kernel.machine,
        kernel_os: node.kernel.os,
        kernel_version: node.kernel.version,
        kernel_release: node.kernel.release,
        ipaddress: node.ipaddress,
        os: node.os,
        domain: (node.domain if node.has_key?('domain')),
        os_version: node.os_version,
        recipes: (node.recipes.as_json if node.has_key?('recipes')),
        hostname: node.hostname,
        macaddress: node.macaddress,
        roles: (node.roles.as_json if node.has_key?('roles')),
        platform: node.platform,
        tags: node.tags.as_json,
        ipmi: (node.ipmi.as_json if node.has_key?('ipmi')),
        run_list: node.run_list.as_json
      }
    end
  end
end