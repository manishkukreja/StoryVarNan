class ReadingList < ActiveRecord::Base
	#has_many :book
	has_one :users
	has_many :line_items , :dependent =>:destroy
end
