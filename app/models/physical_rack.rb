class PhysicalRack
  include Mongoid::Document
  field :index, :type => Integer
  field :name, :type => String
  field :dc_name, :type => String
  has_many :physical_hosts
  belongs_to :datacenter

  def self.list_options
    PhysicalRack.all.map {|r| [r.id, r.name]}
  end
end
