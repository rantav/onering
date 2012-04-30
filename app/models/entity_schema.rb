class EntitySchema
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  
  embeds_many :entity_attributes
  accepts_nested_attributes_for :entity_attributes, :allow_destroy => true

  index :name, unique: true

  def self.list_models_without_schema
    all = ['physical_host', 'datacenter', 'physical_rack']
    schema_names = EntitySchema.all.map {|s| s.name}
    all - schema_names 
  end
end
