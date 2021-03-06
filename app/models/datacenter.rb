class Datacenter
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning
  max_versions 5

  field :name, :type => String
  field :provider_name, :type => String
  field :location, :type => String
  field :contact_info, :type => String
  field :support_link, :type => String
  field :support_email, :type => String
  field :support_phone, :type => String
  

  index :name, unique: true

  has_many :physical_racks
  has_many :audits, :as => :entity

  validates_presence_of :name
    
  def self.list_options
    Datacenter.all.map {|r| [r.id, r.name]}
  end

  def to_param
    (name.gsub('.', '-') if name) || id.to_s
  end
end
