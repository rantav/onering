class AddRememberTokenToAdminUser < ActiveRecord::Migration
  def change
    add_column :admin_users, :remember_token, :string
  end
end
