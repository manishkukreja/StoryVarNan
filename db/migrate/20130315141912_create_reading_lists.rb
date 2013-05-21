class CreateReadingLists < ActiveRecord::Migration
  def change
    create_table :reading_lists do |t|
      t.integer :book_id
      t.integer :user_id

      t.timestamps
    end
  end
end
