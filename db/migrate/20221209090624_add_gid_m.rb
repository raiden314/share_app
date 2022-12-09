class AddGidM < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :gid_m, :string
  end
end
