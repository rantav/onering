class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
#  devise :ldap_authenticatable, 
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  #before_save :get_ldap_email

  def get_ldap_email 
    self.email = Devise::LdapAdapter.get_ldap_param(self.username,"mail") 
  end
end
