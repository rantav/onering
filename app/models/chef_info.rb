class ChefInfo
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :physical_host

  def apply_json(hash)
    do_not_remove = hash.merge({_id: 1, created_at: 1, updated_at: 1})
    attributes.each do |k,v|
      unless do_not_remove.include?(k.to_sym) or do_not_remove.include?(k.to_s)
        remove_attribute(k)
        unset(k)
      end
    end
    self.attributes = hash
  end
end
