def clean
  PhysicalHost.all.delete
  PhysicalRack.all.delete
  Datacenter.all.delete
end

def import(path, dc_name)

  results = CsvMapper.import(path) do
    start_at_row 1
    [r, u, n, ob_name, name, make, model, serial, pdu1, pdu2, status, notes]
  end
  
  datacenter = Datacenter.find_or_create_by(:name => dc_name)
  last_chassis_candidate = nil
  results.each do |line|
    if not (line.name.nil? or line.r.nil?)
      physical_rack = PhysicalRack.find_or_create_by(:index => line.r, :dc_name => datacenter.name)
      if not datacenter.physical_racks.include?(physical_rack)
        datacenter.physical_racks << physical_rack
        datacenter.save
      end
      if physical_rack.name.nil?
        # This is the first line of a rack, so the name refers to a rack name
        physical_rack.name = line.name
        physical_rack.save
      else
        if line.n.nil?
          # This is a 'standard' host. 
          parent_host = nil
          serial = line.serial
          pdu1 = line.pdu1
          pdu2 = line.pdu2
          u = line.u
          n = 1
        else
          # this is a host with a parent.
          parent_host = last_chassis_candidate
          serial = parent_host.serial
          pdu1 = parent_host.pdu1
          pdu2 = parent_host.pdu2
          physical_rack = parent_host.physical_rack
          u = parent_host.u
          n = line.n
        end
        host = PhysicalHost.create(:name => line.name,
                                   :ob_name => line.ob_name,
                                   :make => line.make,
                                   :model => line.model,
                                   :serial => serial, 
                                   #:pdu1 => pdu1, 
                                   #:pdu2 => pdu2,
                                   :status => line.status,
                                   :notes => line.notes,
                                   :physical_rack => physical_rack,
                                   :n => n,
                                   :u => u,
                                   :parent_host => nil) # TODO: why this no works? Should be parent_host

        last_chassis_candidate = host if line.n.nil?
      end
    end
  end
end
