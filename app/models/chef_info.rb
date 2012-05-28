class ChefInfo
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  embedded_in :physical_host
end
