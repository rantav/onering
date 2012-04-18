class GluModule
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :name, :type => String
  field :state, :type => String
  field :context_base_url => String
  field :version => Integer
  
  embedded_in :physical_host
end