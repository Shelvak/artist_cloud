class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :file, null: false
      t.string :title, null: false
      t.string :artist, null: false
      t.string :album
      t.integer :year
      t.string :comment
      t.integer :track
      t.string :genre
      t.integer :user_id, null: false
      t.integer :version, default: 1

      t.timestamps null: false
    end

    add_index :songs, :user_id
    add_index :songs, :title
    add_index :songs, :artist
  end
end
