class Language < ActiveRecord::Base
  belongs_to :book
  
  
  def display_name
    name.titleize.gsub("E ", "e")
  end

end
