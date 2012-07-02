class Setting
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning

  field :index, type: Integer
  field :api_ro_username, :type => String
  field :api_ro_password, :type => String
  field :api_rw_username, :type => String
  field :api_rw_password, :type => String
  field :glu_enabled, :type => Boolean
  field :glu_user, :type => String
  field :glu_pass, :type => String
  field :glu_host_and_port, :type => String
  field :glu_fabric, :type => String
  field :chef_enabled, :type => Boolean
  field :chef_server, :type => String
  field :chef_pem_file, :type => String
  field :chef_username, type: String
  field :glu_configured, type: Boolean, default: false
  field :chef_configured, type: Boolean, default: false

  index :index
  
  def self.get
    find_or_create(index: 0)
  end

  # Return the first object which matches the attributes hash
  # - or -
  # Create new object with the given attributes
  #
  def self.find_or_create(attributes)
    self.where(attributes).first || self.create(attributes)
  end
end
