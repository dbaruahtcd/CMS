class CreateAdminUsersPages < ActiveRecord::Migration[5.0]
  def up
    create_table :admin_users_pages, id: false do |t| # don't need primary key
      t.integer :admin_user_id
      t.integer :page_id
      t.timestamps
    end
    add_index(:admin_users_pages, [:admin_user_id, :page_id])
  end

  def down
    drop_table :admin_users_pages
  end
end
