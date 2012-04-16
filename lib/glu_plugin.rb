require 'yaml'

module GluPlugin

  class Reader
    def initialize
      @config = YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'glu.yaml'))).result)
      @glu_api = GluClient::Api.new :rest_uri => @config['rest_uri'], :fabric => @config['fabric']
    end

    # Updates the roles of the hosts as seen by glu
    def update
      live_model = @glu_api.get_model_live
      clear_all_glu_metadata
      live_model['entries'].each do |entry|
        update_entry entry
      end
    end

    def update_entry(entry)
      agent = entry['agent']
      service = entry['metadata']['product']
      physical_host = PhysicalHost.find_by_name(agent)
      if (physical_host and service)
        puts "Updating #{physical_host.name}. Adding #{service}"
        physical_host.glu_modules << GluModule.new(:name => service) 
        physical_host.save!
      end
    end

    def clear_all_glu_metadata
      puts "Cleaning up all modules information..."
      PhysicalHost.all.each do |h| 
        h.glu_modules = [] 
        h.save
      end
    end
  end

  class Writer
  end
end