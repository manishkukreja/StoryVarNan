class UserMailer < ActionMailer::Base

  default_url_options[:host] = "localhost:3000" 
  
  def feedback(message)
    @message = message
    mail(:to => "ravi.kukreja@gmail.com", :from => 'ravi.kukreja@gmail.com', :subject => "Bookshelf Feedback from #{@message.name}")
  end

  def comment_response(comment, user)
    @comment = comment
    @user = user
    mail :to => @user.email, :from => "manishkukreja@gmail.com", :subject => "Comment Response on Bookshelf"
    #mail :to => "ravi.kukreja@gmail.com", :from => "manishkukreja@gmail.com", :subject => "Comment Response on Bookshelf"
  end

  def invitation(params)
    @message = "Hi #{params[:friend_name]}  Try out this website , its really fun!!!!"
    mail(:to => params[:friend_email],:from => "manishkukreja@gmail.com",:subject => "Invitation to check StoryVarnan" )
  end  

  def password_reset_instructions(user) 
    @user = user
    mail :to => user.email, :from => "ravi.kukreja@gmail.com", :subject =>  "Password Reset Instructions" 
    #:body => :edit_password_reset_url => edit_password_reset_url(user.perishable_token) 
  end  
  
end
