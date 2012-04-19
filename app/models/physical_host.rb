class PhysicalHost
  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps

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
  embeds_many :glu_modules

  index :name # TODO:, unique: true
  index :ob_name, unique: true

  accepts_nested_attributes_for :pdus, :allow_destroy => true
  accepts_nested_attributes_for :child_hosts

  validates_presence_of :name, :n, :u
  validates_numericality_of :n, :only_integer => true
  validates_numericality_of :u, :only_integer => true
  validates_numericality_of :power_consumption, :greater_than_or_equal_to => 0, :allow_blank => true

  def fqdn
    "#{self.name}.#{self.physical_rack.datacenter.name}"
  end

  # The 'geometry' of the host within the datacenter. It's a short string describing the physical location of the 
  # host in the DC, for example: 
  # LGA4.R5.U34:OB1234
  # Or for a chassis part: LGA4.R5.U23.C13.N4:OB1234
  def geometry
  end

  def self.find_by_name(name)
    splits = name.split('.')
    i = splits.length - 1
    while i > 0
      subname = splits[0..i].join('.')
      return PhysicalHost.where(:name => subname).first if PhysicalHost.where(:name => subname).exists?
      i = i - 1
    end
  end

  search_in :name, :make, :serial, :notes, :mac, :status, :ob_name, :model, :physical_rack => :name, :pdus => :name, :glu_modules => :name
end
