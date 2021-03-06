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
  physical_rack = nil
  last_chassis_candidate = nil
  line_number = 1
  results.each do |line|
    line_number += 1
    if line.name.nil?
      puts "XXXXX  #{line_number}  Not importing line b/c name is empty #{line}"
    else
      unless line.r.nil?
        physical_rack = PhysicalRack.find_or_create_by(:index => line.r, :dc_name => datacenter.name)
        if not datacenter.physical_racks.include?(physical_rack)
          datacenter.physical_racks << physical_rack
          datacenter.save
        end
      end
      if physical_rack.name.nil?
        # This is the first line of a rack, so the name refers to a rack name
        physical_rack.name = line.name
        physical_rack.save!
        puts "XXXXXX #{line_number} Not importing line b/c I think this is a rack #{line}"
      else
        pdus = []
        if line.n.nil?
          # This is a 'standard' host. 
          parent_host = nil
          serial = line.serial
          [line.pdu1, line.pdu2].each do |line_pdu|
            unless line_pdu.nil?
              pdus << Pdu.new(:name => line_pdu)
            end
          end
          u = line.u
          n = 1
        else
          # this is a host with a parent.
          parent_host = last_chassis_candidate
          serial = parent_host.serial
          physical_rack = parent_host.physical_rack
          u = parent_host.u
          n = line.n
        end
        begin
          host = PhysicalHost.create!(:name => line.name,
                                      :ob_name => line.ob_name,
                                      :make => line.make,
                                      :model => line.model,
                                      :serial => serial,
                                      :pdus => pdus,
                                      :status => line.status,
                                      :notes => line.notes,
                                      :physical_rack => physical_rack,
                                      :n => n,
                                      :u => u,
                                      :parent_host => parent_host) # TODO: why this no works? Should be parent_host
        rescue => e
          puts e
          puts "Failed to import line #{line_number} #{line}"
          raise e
        end
        last_chassis_candidate = host if line.n.nil?

        #puts "VVVVV  #{line_number} line imported #{line}"
      end
    end
  end
end
