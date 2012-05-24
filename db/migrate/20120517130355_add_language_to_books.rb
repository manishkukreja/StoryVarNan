class AddLanguageToBooks < ActiveRecord::Migration
  def self.up
    add_column :books, :language_id, :integer
  end

  def self.down
    remove_column :books, :language_id
  end
end
