class AgeGroup < ActiveRecord::Base
  attr_accessible :age_range , :display_grade
  has_many :books

end
