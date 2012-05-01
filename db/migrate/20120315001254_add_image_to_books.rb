class AddImageToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :image, :string
    add_column :books, :audio, :string
    add_column :books, :seconds, :integer
    add_column :books, :asciibooks, :boolean
  end

  def self.down
    remove_column :books, :asciibooks
    remove_column :books, :seconds
    remove_column :books, :audio
    remove_column :books, :image
  end
end
