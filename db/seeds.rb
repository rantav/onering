# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

# bootstrap_user = AdminUser.create!(username: 'onering_admin', email: 'onering_admin', password: 'xxx', can_write: true)

ro_api = AdminUser.create!(username: 'ro_api', email: 'ro_api', encrypted_password: 'xxx', can_write: false)
rw_api = AdminUser.create!(username: 'ro_api', email: 'ro_api', encrypted_password: 'xxx', can_write: true)
settings = Setting.get
settings.api_ro_username = ro_api.username
settings.api_ro_password = 'pass'
settings.api_rw_username = rw_api.username
settings.api_rw_password = 'pass'
