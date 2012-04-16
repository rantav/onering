require 'yaml'

class GluDataRetriever

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
    
  end

  def clear_all_glu_metadata
    puts "TODO..."
  end
end