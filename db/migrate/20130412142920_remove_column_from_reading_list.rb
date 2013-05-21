class RemoveColumnFromReadingList < ActiveRecord::Migration
  def up
  	remove_column :reading_lists, :book_id
  end

  def down
  	add_column :reading_lists, :book_id , :string
  end
end
