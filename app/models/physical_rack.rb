class PhysicalRack
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning
  max_versions 5

  field :index, :type => Integer
  field :name, :type => String
  field :number_of_us, :type => Integer

  has_many :physical_hosts
  belongs_to :datacenter
  has_many :audits, :as => :entity

  index :name, unique: true
  index :index

  validates_numericality_of :number_of_us, :only_integer => true, :allow_blank => true
  validates_numericality_of :index, :only_integer => true
  validates_presence_of :name
  validates_associated :datacenter
  
  def self.list_options
    PhysicalRack.all.map {|r| [r.id, r.name]}
  end

  def to_param
    (name.gsub('.', '-') if name) || id.to_s
  end

end
