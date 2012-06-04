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
      live_glu_modules = create_modules(live_model)
      clear_old_glu_modules(live_glu_modules)
      live_glu_modules.each do |glu_module|
        update_agent_module glu_module
      end
    end

    def create_modules(live_model)
      live_modules = []
      live_model['entries'].each do |entry|
        glu_module = create_module(entry)
        live_modules << glu_module unless glu_module.nil?
      end
      live_modules
    end

    def create_module(entry)
      agent = entry['agent']
      service = entry['metadata']['product']
      entry_state = entry['entryState']
      context_base_url = entry['initParameters']['contextBaseUrl'] if entry['initParameters']
      version = entry['metadata']['version']
      if (agent and service)
        return GluModule.new(agent: agent,
                             name: service,
                             state: entry_state,
                             context_base_url: context_base_url,
                             version: version)
      end
    end

    def update_agent_module(glu_module)
      physical_host = PhysicalHost.find_by_name(glu_module.agent)
      return if physical_host.nil?
      found = glu_module.find_in_list(physical_host.glu_modules)
      if found
        Rails.logger.info "Glu: (Maybe) updating #{physical_host.name} with #{glu_module.name}"
        found.attributes = glu_module.attributes.except('_id','created_at','updated_at')
      else
        Rails.logger.info "Glu: Updating #{physical_host.name} by adding #{glu_module.name}"
        physical_host.glu_modules << glu_module
      end
      if physical_host.changed?
        Rails.logger.info "Glu: Updating #{physical_host.name} for #{glu_module.name}. Changed: #{physical_host.glu_modules.each{|glu_module| glu_module.changes}}"
        puts "Glu: Updating #{physical_host.name} for #{glu_module.name}. Changed: #{physical_host.glu_modules.each{|glu_module| glu_module.changes}}"
        physical_host.audits << Audit.new(source: 'cron', action: 'update_glu')
        physical_host.save!
      end
    end


    # Removes glu modules from hosts if they are not in the live model
    def clear_old_glu_modules(live_glu_modules)
      Rails.logger.info "Cleaning up old glu modules..."
      PhysicalHost.all.each do |physical_host|
        physical_host.glu_modules.each do |glu_module|
          if not glu_module.find_in_list(live_glu_modules)
            Rails.logger.info "Glu: Deleting #{glu_module.name} from #{physical_host.name}"
            puts "Glu: Deleting #{glu_module.name} from #{physical_host.name}"
            physical_host.audits << Audit.new(source: 'cron', action: "remove_glu_module #{glu_module.name}")
            glu_module.delete
            physical_host.save!
          end
        end
      end
    end
  end

  class Writer
  end
end