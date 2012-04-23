class EntityAttribute
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :entity_schema
  
  field :name, :type => String
  field :type, :type => String

  validates_presence_of :name
  validates :type, :inclusion => {:in => %w(string integer)}

end
