require 'ipaddr'

# opening up IPAddr to add an accessor to mask_addr
class IPAddr
  attr_accessor :mask_addr
  def get_mask
    self.mask_addr.to_s(2).count("1")
  end
end

class IpBlock
  include Mongoid::Document
  include Mongoid::Timestamps
  field :base_address, :type => Integer, default: 0
  field :mask, :type => Integer, default: 32
  attr :display

  validate :valid_ip

  # Parse an IP atring, such as "127.0.0.1" or "127.0.0.1/28"
  def self.parse(ip_str)
    ip = IPAddr.new(ip_str)
    base_address = ip.to_i
    mask = ip.get_mask
    IpBlock.new(base_address: base_address, mask: mask)
  end

  def display
    ip = IPAddr.new(base_address, Socket::AF_INET)
    "#{ip.to_s}/#{mask}"
  end

  def valid_ip
    begin
      ip = IPAddr.new(base_address, Socket::AF_INET)
      ip = ip.mask(mask)
      return true
    rescue => e
      errors.add(:base_address, "Invalid base address or mask #{e}")
    end
  end
end
