require Rails.root.to_s+'/lib/authentication'
require Rails.root.to_s+'/lib/authorization'



  class ApplicationController < ActionController::Base
    include Bookshelf::Authorization
    include Bookshelf::Authentication
    protect_from_forgery
    
    helper_method :current_user ,:is_user_admin?
   private
    
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end
    
    # def authorize
    #   unless current_user.username == 'admin'
    #   flash[:notice] = 'You need to be an Administrator to access this page'
    #   redirect_to root_url
    #   false
    #   end
    # end

    def require_user
        unless current_user
          #store_location
          flash[:notice] = "You must be logged in to access this page"
          redirect_to new_user_session_url 
          return false
        end
    end

    def reading_list(params)
        @reading_list = ReadingList.find_or_create_by_user_id(:user_id => session[:user_credentials_id])
        session[:reading_list_id] = @reading_list.id
        return @reading_list
    end
  end
