class CreateUserUrls < ActiveRecord::Migration[5.0]
  def up
    create_table :user_urls do |t|
      t.references :user
      t.references :url
      t.timestamps
    end
  end

  def down
    drop_table :user_urls
  end
end
