class U
  include Mongoid::Document
  field :index, :type => Integer
  field :name, :type => String
  has_many :ns
  belongs_to :datacenter
end
