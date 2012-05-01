class AddSiteUrlToComments < ActiveRecord::Migration
  def self.up
    add_column :comments, :site_url, :string
  end

  def self.down
    remove_column :comments, :site_url
  end
end
