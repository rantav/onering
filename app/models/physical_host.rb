class PhysicalHost
  include Mongoid::Document
  include Mongoid::Search

  field :name, :type => String
  field :n, :type => Integer
  field :u, :type => Integer
  field :type, :type => String
  field :serial, :type => String
  field :notes, :type => String
  field :mac, :type => String
  field :power_consumption, :type => Float

  has_one :parent_host, :class_name => 'PhysicalHost', :inverse_of => :child_hosts
  has_many :child_hosts, :class_name => 'PhysicalHost', :inverse_of => :parent_host
  belongs_to :physical_rack
  embeds_many :pdus

  accepts_nested_attributes_for :pdus

  validates_presence_of :name, :n, :u
  validates_numericality_of :n, :only_integer => true
  validates_numericality_of :u, :only_integer => true
  validates_numericality_of :power_consumption, :greater_than_or_equal_to => 0

  search_in :name, :type, :serial, :pdu1, :pdu2, :notes, :mac, :physical_rack => :name
end
