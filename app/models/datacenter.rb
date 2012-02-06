class Datacenter
  include Mongoid::Document
  field :name, :type => String
  has_many :physical_racks

  validates_presence_of :name
    
  def self.list_options
    Datacenter.all.map {|r| [r.id, r.name]}
  end

end
