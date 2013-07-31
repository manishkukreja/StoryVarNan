class AddColumnFlashVideoToBook < ActiveRecord::Migration
  def change
    add_column :books, :flash_video, :string
  end
end
