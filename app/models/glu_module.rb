class GluModule
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  
  embedded_in :physical_host
end