class Worklog
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name, :type => String
  field :start, :type => Time
  field :end, :type => Time
  field :error, :type => String

  has_many :audits

  def to_s
    "Worklog(_id=#{_id})"
  end
end
