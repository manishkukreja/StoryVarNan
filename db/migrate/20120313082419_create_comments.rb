class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.integer :book_id
      t.text :content
      t.string :f_name
      t.string :l_name
      t.string :email
      t.string :user_id
      t.string :referrer
      t.string :user_ip
      t.integer :position

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
