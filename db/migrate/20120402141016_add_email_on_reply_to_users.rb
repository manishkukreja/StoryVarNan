class AddEmailOnReplyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email_on_reply, :boolean
  end

  def self.down
    remove_column :users, :email_on_reply, :boolean
  end
end
