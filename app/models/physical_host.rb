class PhysicalHost
  include Mongoid::Document
  include Mongoid::Search

  field :name, :type => String
  field :ob_name, :type => String
  field :n, :type => Integer
  field :u, :type => Integer
  field :model, :type => String
  field :make, :type => String
  field :serial, :type => String
  field :notes, :type => String
  field :mac, :type => String
  field :power_consumption, :type => Float
  field :status, :type => String

  belongs_to :parent_host, :class_name => 'PhysicalHost', :inverse_of => :child_hosts
  has_many :child_hosts, :class_name => 'PhysicalHost', :inverse_of => :parent_host
  belongs_to :physical_rack
  embeds_many :pdus

  accepts_nested_attributes_for :pdus

  validates_presence_of :name, :n, :u
  validates_numericality_of :n, :only_integer => true
  validates_numericality_of :u, :only_integer => true
  validates_numericality_of :power_consumption, :greater_than_or_equal_to => 0, :allow_blank => true

  search_in :name, :make, :serial, :pdu1, :pdu2, :notes, :mac, :status, :ob_name, :model, :physical_rack => :name, :pdus => :name

  def self.list_parents
    PhysicalHost.where(name: /^CHASSIS/i).map {|h| [h.id, h.name]}
  end
end
