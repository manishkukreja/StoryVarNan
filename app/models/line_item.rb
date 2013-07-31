class LineItem < ActiveRecord::Base
	belongs_to :book
	belongs_to :reading_list
	belongs_to :user
end
