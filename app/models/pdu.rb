class Pdu
  include Mongoid::Document

  field :name, :type => String
  field :voltage, :type => Integer
  field :amps, :type => Float

  embedded_in :physical_host

  validates_presence_of :name
end
