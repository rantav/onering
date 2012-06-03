class Audit
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :source, :type => String
  field :action, :type => String
  
  belongs_to :entity, :polymorphic => true

  index :created_at
end
