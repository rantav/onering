class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :fqdn
      t.string :dc
      t.string :serial
      t.string :make
      t.string :mac
      t.string :role

      t.timestamps
    end
  end
end
