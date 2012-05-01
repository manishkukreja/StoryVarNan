class AddSiteUrlToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :site_url, :string
  end

  def self.down
    remove_column :users, :site_url
  end
end
