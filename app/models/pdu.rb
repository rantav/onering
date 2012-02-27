class Pdu
  include Mongoid::Document

  field :name, :type => String
  field :voltage, :type => Integer
  field :amps, :type => Float

  embedded_in :physical_host

  validates_presence_of :name
  validates_numericality_of :voltage, :allow_blank => true
  validates_numericality_of :amps, :allow_blank => true
end
