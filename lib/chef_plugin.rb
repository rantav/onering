require 'chef/rest'

module ChefPlugin
  def self.load_config
    YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'chef.yaml'))).result)
  end

  @config = load_config

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
        physical_host.chef_info = ChefInfo.new(as_json(node))
        physical_host.save!
      else
        Rails.logger.info("No onering node found for #{node_name}. Will not update chef data")
      end
    end

    # Removes some of the information from this node's info so that it can be safely stored
    def as_json(node)
      {
        name: node.name,
        kernel: {
          name: node.kernel.name,
          machine: node.kernel.machine,
          os: node.kernel.os,
          version: node.kernel.version,
          release: node.kernel.release
        },
        ipaddress: node.ipaddress,
        os: node.os,
        domain: node.domain,
        os_version: node.os_version,
        recipes: node.recipes.as_json,
        hostname: node.hostname,
        macaddress: node.macaddress,
        roles: node.roles.as_json,
        platform: node.platform,
        uptime_seconds: node.uptime_seconds,
        tags: node.tags.as_json,
        ipmi: (node.ipmi.as_json if node.has_key?('ipmi')),
        run_list: node.run_list.as_json
      }
    end
  end
end