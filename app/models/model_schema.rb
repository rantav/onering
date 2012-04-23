class ModelSchema
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :model_name, :type => String

  embeds_many :model_attributes

  index :model_name, unique: true
end
