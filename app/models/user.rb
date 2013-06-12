class User < ActiveRecord::Base
  attr_accessible :name, :email, :site_url, :email_on_reply,:username, :role, :password, :password_confirmation, :first_name , :last_name
  acts_as_authentic
  has_many :comments
  has_many :user_invitee
  letsrate_rater
  
  def banned?
    banned_at
  end
  
  def role?(role)
    role.include? roles.to_s
  end
end
