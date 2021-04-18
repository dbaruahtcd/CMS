class RenamePasswordColumnInAdminUsers < ActiveRecord::Migration[5.0]
  def up
    remove_column :admin_users, :hashed_password
    add_column :admin_users, :password_digest, :string
  end

  def down
    remove_column :admin_users, :password_digest
    add_columns :admin_users, :hash_password, length: 40
  end
end
