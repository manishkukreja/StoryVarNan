class UsersController < ApplicationController
#before_filter :authorize
before_filter :logging_required , :except => [:create , :new]
before_filter :load_current_user , :only => [:edit, :update]
#load_and_authorize_resource


  def index
    if is_user_admin?
      @users = User.all   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
    else
      flash[:notice] = 'You need to be an Admin user to access this page'
      redirect_to root_url

    end
  end

  
  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    if is_user_admin?
      @user = User.find(params[:id])
    else
      @user = current_user
    end  
  end

  def show
    if is_user_admin?
      @user = User.find(params[:id])
    else 
       @user = User.find(session[:user_credentials_id])
    end
     @invitation_grid = initialize_grid(UserInvitee, :conditions => ['user_id = ?',@user.id]
        )
     
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        already_invited = UserInvitee.find_by_friend_email(params[:user][:email])
        if already_invited
          already_invited.update_attributes(:invitation_status => 'Accepted')
        end  
        format.html { redirect_to(root_url, :notice => 'Registration was successful') }
        #format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = current_user

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(root_url, :notice => 'Successfully updated the profile.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def invitation_status_check(friend_detail)
    UserInvitee.find_all_by_user_id(@user.id)
    a = friend_detail.map{|a| a.friend_email}
    a.each do |frd_email|
       if User.all.map{|z| z.email}.include?(frd_email)
          return "Accepted"
        else
          return "Still Pending"
        end
    end
  end

   private
  def load_current_user
    @user = current_user
  end
end