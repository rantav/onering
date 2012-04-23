class EntitySchema
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  
  embeds_many :entity_attributes
  accepts_nested_attributes_for :entity_attributes, :allow_destroy => true

  index :name, unique: true

end
