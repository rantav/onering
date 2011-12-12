class Datacenter
  include Mongoid::Document
  field :name, :type => String
  has_many :us
end
