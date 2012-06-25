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

  before_save :get_ldap_email
  
  def get_ldap_email
    self.email = Devise::LdapAdapter.get_ldap_param(self.username, "mail")
  end
end
