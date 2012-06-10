class Worklog
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :start, :type => Time
  field :end, :type => Time

  has_many :audits
end
