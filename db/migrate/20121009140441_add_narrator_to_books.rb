class AddNarratorToBooks < ActiveRecord::Migration
  
  def self.up
    add_column :books, :narrator, :string
  end

  def self.down
    remove_column :books, :narrator
  end
end
