module GluPlugin

  def self.load_config
    YAML::load(ERB.new(IO.read(File.join(Rails.root, 'config', 'glu.yaml'))).result)
  end

  @config = load_config

  def self.url_for_module(m)
    "#{@config['console_uri']}system/filter?systemFilter=metadata.product%3D%27#{m.name}%27&title=product+%5B#{m.name}%5D&groupBy=metadata.product"
  end

  class Reader
    def initialize
      @config = GluPlugin::load_config
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
      entry_state = entry['entryState']
      context_base_url = entry['initParameters']['contextBaseUrl'] if entry['initParameters']
      version = entry['metadata']['version']
      physical_host = PhysicalHost.find_by_name(agent)
      if (physical_host and service)
        Rails.logger.info "Updating #{physical_host.name}. Adding #{service}"
        physical_host.glu_modules << GluModule.new(:name => service,
                                                   :state => entry_state,
                                                   :context_base_url => context_base_url,
                                                   :version => version) 
        physical_host.audits << Audit.new(source: 'cron', action: 'update_glu')
        physical_host.save!
      end
    end

    def clear_all_glu_metadata
      Rails.logger.info "Cleaning up all modules information..."
      PhysicalHost.all.each do |h| 
        h.glu_modules = [] 
        h.save
      end
    end
  end

  class Writer
  end
end