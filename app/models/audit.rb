class Audit
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :source, :type => String
  field :action, :type => String
  has_one :user
  
  belongs_to :entity, :polymorphic => true
  belongs_to :worklog
  belongs_to :admin_user
  
  index :created_at
end
