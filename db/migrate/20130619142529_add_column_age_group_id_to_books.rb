class AddColumnAgeGroupIdToBooks < ActiveRecord::Migration
  def change
    add_column :books, :age_group_id, :integer
  end
end
