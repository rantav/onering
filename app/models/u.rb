class U
  include Mongoid::Document
  field :index, :type => Integer
  has_many :physical_hosts
  belongs_to :physical_rack
end