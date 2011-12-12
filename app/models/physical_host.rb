class PhysicalHost
  include Mongoid::Document
  field :name, :type => String
  field :n, :type => Integer
  field :type, :type => String
  field :serial, :type => String
  field :pdu1, :type => String
  field :pdu2, :type => String
  belongs_to :u
end
