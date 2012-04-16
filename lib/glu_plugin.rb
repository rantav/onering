require 'yaml'
include ActionView::Helpers::UrlHelper

module GluPlugin
  @config = YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'glu.yaml'))).result)
  def self.link_to_module(module_name)
    link_to module_name, "#{@config['console_uri']}system/filter?systemFilter=metadata.product%3D%27#{module_name}%27&title=product+%5B#{module_name}%5D&groupBy=metadata.product"
  end

  class Reader
    def initialize
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