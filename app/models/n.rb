class N
  include Mongoid::Document
  field :index, :type => Integer
  has_one :physical_host
  belongs_to :u
end
