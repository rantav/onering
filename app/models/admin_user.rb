class AdminUser
  include Mongoid::Document

  devise :ldap_authenticatable, :rememberable, :trackable #, :database_authenticatable

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :username,           :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""
  field :remember_token,     :type => String, :default => ""

  validates_presence_of :email
  validates_presence_of :encrypted_password

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  has_many :audits
    
  index :email

  before_save :get_ldap_email
  
  def get_ldap_email
    self.email = Devise::LdapAdapter.get_ldap_param(self.username, "mail") unless api_user?
  end

  def api_user?
    api_ro_user? or api_rw_user?
  end

  def api_ro_user?
    self.username == Setting.get.api_ro_username
  end

  def api_rw_user?
    self.username == Setting.get.api_rw_username
  end

  def self.authenticate_api_user(user, password)
    self.api_user(user) if (user == Setting.get.api_ro_username and password == Setting.get.api_ro_password) or 
                           (user == Setting.get.api_rw_username and password == Setting.get.api_rw_password)
  end

  def self.api_user(user)
    self.find_or_create(email: user, username: user, encrypted_password: 'xxx')
  end

  # Return the first object which matches the attributes hash
  # - or -
  # Create new object with the given attributes
  #
  def self.find_or_create(attributes)
    self.where(attributes).first || self.create(attributes)
  end

end
