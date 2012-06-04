class GluModule
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :state, :type => String
  field :context_base_url, :type => String
  field :version, :type => Integer
  field :agent, :type => String

  embedded_in :physical_host

  def details_str
    "State: #{state}<br/> Version: #{version}<br/> Last update: #{created_at.to_formatted_s(:short)}"
  end

  def state_label_color
    return 'label-success' if state == 'running'
    return 'label-important' if state == 'stopped'
    return 'label-warning'
  end

  # Tests whether the glu related attributes are the same in both modules
  def glu_module_equal?(other)
    name == other.name and agent == other.agent
  end

  def find_in_list(modules_list)
    modules_list.each do |glu_module|
      if self.glu_module_equal?(glu_module)
        return glu_module
      end
    end
    nil
  end
end