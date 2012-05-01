class FeedbackMessagesController < ApplicationController
 
 #before_filter :authorize
 
 def new
    @feedback_message = FeedbackMessage.new
    if current_user
      @feedback_message.name = current_user.username
      @feedback_message.email = current_user.email
    end
  end
 
 def create
    if params[:email].present?
      redirect_to root_url, :notice => "Your feedback message was caught by the spam filter because you filled in the invisible email field. Please try again without filling in the false email field and let me know that this happened."
    else
      @feedback_message = FeedbackMessage.new(params[:feedback_message])
      if @feedback_message.save
        UserMailer.feedback(@feedback_message).deliver
        redirect_to root_url, :notice => "Thank you for the feedback."
      else
        render :new
      end
    end
  end
 
 ##########################
  # def new
    # @feedback_message = FeedbackMessage.new
# 
    # respond_to do |format|
      # format.html # new.html.erb
      # format.xml  { render :xml => @feedback_message }
    # end
  # end

  # def create
    # @feedback_message = FeedbackMessage.new(params[:feedback_message])
# 
    # respond_to do |format|
      # if @feedback_message.save
        # format.html { redirect_to(@feedback_message, :notice => 'Feedback message was successfully created.') }
        # format.xml  { render :xml => @feedback_message, :status => :created, :location => @feedback_message }
      # else
        # format.html { render :action => "new" }
        # format.xml  { render :xml => @feedback_message.errors, :status => :unprocessable_entity }
      # end
    # end
  # end

  


end
