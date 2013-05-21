module Bookshelf
	
	module Authentication
		
		def logging_required
	  	unless current_user
	    	flash[:notice] = "You must be logged in to access this page"
	      redirect_to new_user_session_url
	  	end  
  	end

		def is_user_admin?
		  current_user.role.eql?('admin')
		end

	end

end	