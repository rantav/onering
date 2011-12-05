class PhysicalHost
  include Mongoid::Document
  field :name, :type => String
  field :r, :type => Integer
  field :u, :type => Integer
  field :n, :type => Integer
  field :type, :type => String
  field :serial, :type => String
  field :pdu1, :type => String
  field :pdu2, :type => String
  field :label, :type => String
  field :status, :type => String
  field :notes, :type => String
  belongs_to :datacenter
end
