class PhysicalRack
  include Mongoid::Document
  field :index, :type => Integer
  field :name, :type => String
  field :dc_name, :type => String
  has_many :physical_hosts
  belongs_to :datacenter
end
