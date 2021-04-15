class Subjects < ActiveRecord::Migration[5.0]
  def up
    create_table :subjects do |t|
      t.string 'name', :limit => 100
      t.integer 'position'
      t.boolean 'visible', :default => false
      t.timestamps
    end
  end

  def down
    drop_table :subjects
  end
end
