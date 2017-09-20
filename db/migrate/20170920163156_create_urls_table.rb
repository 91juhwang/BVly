class CreateUrlsTable < ActiveRecord::Migration[5.0]
  def up
    create_table :urls do |t|
      t.string :full_url
      t.integer :access_count, default: 0
    end
    add_index :urls, :full_url, unique: true
    add_index :urls, :access_count
  end

  def down
    drop_table :urls
  end
end
