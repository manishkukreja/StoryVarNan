class User < ActiveRecord::Base
  attr_accessible :name, :email, :site_url, :email_on_reply,:username, :role, :password, :password_confirmation, :first_name , :last_name,:provider,:uid
  acts_as_authentic
  has_many :comments
  has_many :user_invitee
  has_many :social_authentications
  has_many :line_items
  letsrate_rater
  
  def banned?
    banned_at
  end

  def deliver_password_reset_instructions!  
    reset_perishable_token!  
    UserMailer.password_reset_instructions(self).deliver
  end  
  
  def role?(role)
    role.include? roles.to_s
  end

  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email']
   
    # Update user info fetching from social network
    case omniauth['provider']
    when 'facebook'
      # fetch extra user info from facebook
    when 'twitter'
      # fetch extra user info from twitter
    end
  end

end
