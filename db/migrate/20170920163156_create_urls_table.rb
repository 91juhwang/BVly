class CreateUrlsTable < ActiveRecord::Migration[5.0]
  def up
    create_table :urls do |t|
      t.string :url
    end
  end

  def down
    drop_table :urls
  end
end