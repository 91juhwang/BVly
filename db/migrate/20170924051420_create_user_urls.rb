class CreateUserUrls < ActiveRecord::Migration[5.0]
  def up
    create_table :user_urls do |t|
      t.string :full_url
      t.integer :access_count, default: 0
      t.string :personal_url
      t.references :user
      t.timestamps
    end
  end

  def down
    drop_table :user_urls
  end
end
