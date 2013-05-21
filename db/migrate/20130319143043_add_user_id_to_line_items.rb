class AddUserIdToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :user_id, :integer
  end
end
