class PhysicalHost
  include Mongoid::Document
  field :name, :type => String
  field :n, :type => Integer
  field :u, :type => Integer
  field :type, :type => String
  field :serial, :type => String
  field :pdu1, :type => String
  field :pdu2, :type => String
  has_one :parent_host, :class_name => 'PhysicalHost', :inverse_of => :child_hosts
  has_many :child_hosts, :class_name => 'PhysicalHost', :inverse_of => :parent_host
  belongs_to :physical_rack
end
