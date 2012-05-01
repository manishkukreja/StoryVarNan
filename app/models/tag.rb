class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :books, :through => :taggings
  
  
  
  def display_name
    name.titleize.gsub("E ", "e")
  end
end
