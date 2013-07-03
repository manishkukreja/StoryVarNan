class SocialAuthentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :user_id
  belongs_to :user

  validates :user_id, :uid, :provider, :presence => true

end
