class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.string :name
      t.string :permalink
      t.text :description
      t.text :notes
      t.datetime :published_at
      t.integer :position
      t.integer :comments_count
      t.boolean :legacy
      t.text :file_sizes

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
