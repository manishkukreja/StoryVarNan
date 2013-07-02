class SocialAuthenticationsController < ApplicationController
  def create
    omniauth = request.env['omniauth.auth']
    @social_authentication = SocialAuthentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
 
    if @social_authentication
      # User is already registered via social network with application
      flash[:info] = 'Signed in successfully.'
      sign_in_and_redirect(@social_authentication.user , @social_authentication)
    elsif current_user
      # User is signed in but has not already authenticated with this social network
      current_user.social_authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      current_user.apply_omniauth(omniauth)
      current_user.save
 
      flash[:info] = 'Authentication successful.'
      redirect_to root_url
    else
      # User is new to this application
      generate_password
      user = User.new(:first_name=>omniauth[:info][:first_name],
                      :last_name=>omniauth[:info][:last_name],
                      :username =>omniauth[:info][:email], 
                      :provider => omniauth['provider'], 
                      :uid => omniauth['uid'],:email=> omniauth[:info][:email],
                      :password => @random_password,
                      :password_confirmation => @random_password )
      if user.save!
        user.social_authentications.create!(:provider => omniauth['provider'], 
                                          :uid => omniauth['uid'])
        flash[:info] = "User created and signed in successfully.Your temperory password for StoryVarnan is <mark>#{@random_password} </mark>, Please change it from current screen"
        sign_in_and_redirect(user,nil)
      else
        session[:omniauth] = omniauth.except('extra')
        redirect_to new_user_path
      end
    end
  end
 
  def destroy
    social_authentication = current_user.social_authentications.find(params[:id])
    social_authentication.destroy
    flash[:notice] = 'Successfully destroyed authentication.'
    redirect_to root_url
  end
 
  private
  def sign_in_and_redirect(user,var)
    unless current_user
      user_session = UserSession.new(User.find_by_email(user.email))
      user_session.save
    end
    if !@social_authentication
      redirect_to edit_user_path(:id)
    else
      redirect_to root_url
    end  
  end

  def generate_password
    @random_password = ('0'..'z').to_a.shuffle.first(8).join
    @random_password
  end

end
