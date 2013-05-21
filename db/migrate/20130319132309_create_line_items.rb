class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :book_id
      t.integer :reading_list_id

      t.timestamps
    end
  end
end
