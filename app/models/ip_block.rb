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
  field :base_address, :type => Integer, default: 0, presence: true
  field :mask, :type => Integer, default: 32, presence: true

  attr :base_address_str, true
  attr :display

  validate :valid_ip

  # Parse an IP atring, such as "127.0.0.1" or "127.0.0.1/28"
  def self.parse(ip_str)
    ip = IPAddr.new(ip_str)
    base_address = ip.to_i
    mask = ip.get_mask
    IpBlock.new(base_address: base_address, mask: mask)
  end

  def base_address_str
    ip = IPAddr.new(base_address, Socket::AF_INET)
    ip.to_s
  end

  def base_address_str=(str)
    ip = IPAddr.new(str)
    self.base_address = ip.to_i
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

  def next_free_addresses(start, how_many, used_ips)
    ip = IPAddr.new(base_address, Socket::AF_INET)
    ip = ip.mask(mask)
    raise "Start IP (#{start}) out of range #{ip.inspect}" unless ip.include?(start)
    start_ip = IPAddr.new(start)
    addresses = []
    ip.to_range.each do |a|
      s = a.to_s
      addresses << s unless a < start_ip or addresses.size >= how_many or used_ips.include?(s)
    end
    addresses
  end
end
