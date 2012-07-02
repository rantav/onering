# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# bootstrap_user = AdminUser.create!(username: 'onering_admin', email: 'onering_admin', password: 'xxx', can_write: true)

settings = Setting.get

unless AdminUser.where({email: 'ro_api'}).first
  ro_api = AdminUser.create!(username: 'ro_api', email: 'ro_api', encrypted_password: 'xxx', can_write: false)
  settings.api_ro_username = ro_api.username
  settings.api_ro_password = 'pass'
end
unless AdminUser.where({email: 'rw_api'}).first
  rw_api = AdminUser.create!(username: 'rw_api', email: 'rw_api', encrypted_password: 'xxx', can_write: true)
  settings.api_rw_username = rw_api.username
  settings.api_rw_password = 'pass'
end

unless settings.glu_configured
  settings.glu_enabled = false
  settings.glu_user = 'glu_username'
  settings.glu_pass = 'glu_password'
  settings.glu_host_and_port = 'glu.example.com:8080'
  settings.glu_fabric = 'glu_fabric'
  settings.glu_configured = true
end

unless settings.chef_configured
  settings.chef_enabled = false
  settings.chef_server = 'http://chef.example.com:4040'
  settings.chef_pem_file = '/path/to/pem/file.pem'
  settings.chef_username = 'chef_username'
  settings.chef_configured = true
end

settings.save