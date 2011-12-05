class Datacenter
  include Mongoid::Document
  field :name, :type => String
  has_many :physical_hosts
end
