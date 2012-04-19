class GluModule
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :name, :type => String
  field :state, :type => String
  field :context_base_url => String
  field :version => Integer

  embedded_in :physical_host

  def details_str
    "State: #{state}<br/> Version: #{version}<br/> Last update: #{created_at.to_formatted_s(:short)}"
  end

  def state_label_color
    return 'label-success' if state == 'running'
    return 'label-important' if state == 'stopped'
    return 'label-warning'
  end
end