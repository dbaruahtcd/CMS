class Pages < ActiveRecord::Migration[5.0]
  def up
    create_table :pages do |t|
      t.integer :subject_id
      t.column "name", :string, :limit => 150
      t.integer "permalink"
      t.integer "position"
      t.boolean "visible"
      t.timestamps
    end

    add_index(:pages, :subject_id)
    add_index(:pages, :permalink)
  end

  def down
    drop_table :pages
  end
end
