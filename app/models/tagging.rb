class Tagging < ActiveRecord::Base
  belongs_to :book
  belongs_to :tag
end
