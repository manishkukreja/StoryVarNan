class AddImageLinkToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :image_link, :string
  end

  def self.down
    remove_column :books, :image_link
  end
end
