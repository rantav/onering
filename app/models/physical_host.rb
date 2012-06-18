class PhysicalHost
  include Mongoid::Document
  include Mongoid::Search
  include Mongoid::Timestamps
  
  include Mongoid::Versioning
  max_versions 5

  field :name, :type => String
  field :ob_name, :type => String
  field :n, :type => Integer
  field :u, :type => Integer
  field :model, :type => String
  field :make, :type => String
  field :serial, :type => String
  field :notes, :type => String
  field :power_consumption, :type => Float
  field :status, :type => String

  belongs_to :parent_host, :class_name => 'PhysicalHost', :inverse_of => :child_hosts
  has_many :child_hosts, :class_name => 'PhysicalHost', :inverse_of => :parent_host
  belongs_to :physical_rack
  embeds_many :pdus
  embeds_many :glu_modules
  embeds_one :chef_info
  has_many :audits, :as => :entity

  index :name # TODO:, unique: true
  index :ob_name, unique: true
  index :u

  accepts_nested_attributes_for :pdus, :allow_destroy => true
  accepts_nested_attributes_for :child_hosts

  validates_presence_of :name, :n, :u
  validates_numericality_of :n, :only_integer => true
  validates_numericality_of :u, :only_integer => true
  validates_numericality_of :power_consumption, :greater_than_or_equal_to => 0, :allow_blank => true

  # Collects all IP addresses from the hosts in the database
  def self.all_ip_addresses
    addresses = []
    PhysicalHost.all.each do |host|
      addresses << host.ip_address if host.ip_address
    end
    addresses
  end

  def fqdn
    "#{self.name}.#{self.physical_rack.datacenter.name}"
  end

  def ip_address
    chef_info.ipaddress if chef_info
  end

  def mac_addresses
    chef_info.network['interfaces'].map{|k,v| v['lladdr']} if chef_info
  end

  def mac_addresses_display
    addresses = mac_addresses
    if addresses
      mac_addresses.to_s
    else
      "No data from chef"
    end
  end

  # Takes the first letter of the host name and the number at the end of it.
  # for example, short name for CHASSIS15 is C15
  def short_name
    name[0] + name.match(/(\d+$)/)[0]
  end

  # The 'geometry' of the host within the datacenter. It's a short string describing the physical location of the 
  # host in the DC, for example: 
  # LGA4.R5.U34:OB1234
  # Or for a chassis part: LGA4.R5.U23.C13.N4:OB1234
  def geometry
    if parent_host
      return "#{parent_host.physical_rack.name}.#{parent_host.short_name}.N#{n}:#{ob_name || name}"
    elsif physical_rack
      return "#{physical_rack.name}:#{ob_name || name}"
    end
  end

  def self.find_by_name(name)
    return nil if name.nil?
    splits = name.split('.')
    i = splits.length - 1
    while i >= 0
      subname = splits[0..i].join('.')
      host = PhysicalHost.any_of({:name => subname}, {:ob_name => subname}).first
      return host unless host.nil?
      i = i - 1
    end
  end

  search_in :name, :make, :serial, :notes, :mac, :status, :ob_name, :model, :physical_rack => :name, :pdus => :name, :glu_modules => :name
end
