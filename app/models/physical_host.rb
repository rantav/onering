class PhysicalHost
  include Mongoid::Document
  include Mongoid::Search
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

  validates :n, :numericality => { :only_integer => true }   
  validates :u, :numericality => { :only_integer => true }   
  search_in :name, :type, :serial, :pdu1, :pdu2, :physical_rack => :name
end
