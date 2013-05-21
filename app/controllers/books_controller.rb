 class BooksController < ApplicationController

  
  def index
    @tag = Tag.find(params[:tag_id]) if params[:tag_id]    
    @language = Language.find(params[:language_id]) if params[:language_id]
    @narrator_list = Book.find_narrator(params)
        
    if params[:search]
        @books=Book.search_published(params[:search])
    else
        @books=Book.find_book(params) 
    end
     respond_to do |format|
     format.html {@books = @books.paginate(:page => params[:page], :per_page => books_per_page) }
     format.rss
    end
  end


  def show
    @book = Book.find(params[:id])
    @comments = Comment.find_all_by_book_id(params[:id])
    @other_books = Book.find_all_by_narrator(@book.narrator)    
    if params[:id] != @book.to_param   # Not understood 
      headers["Status"] = "301 Moved Permanently"
      redirect_to book_url(@book)
    else
      @comment = Comment.new(:book_id => @book.id, :user_id => current_user)
    end
  end

  def new
    @book = Book.new
    @book.position = Book.maximum(:position).to_i + 1
  
  end


  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to(@book, :notice => 'Book was successfully created.') }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to(@book, :notice => 'Book was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end

  def reading_list_pane
    #raise params.inspect
  end


  def books_per_page
    case params[:view]
    when "list" then 10
    when "grid" then 4
    else 4
    end
  end
  
  def invite_friends
    user_details = User.find(session[:user_credentials_id])
    render layout: false
      if params[:friend_name]  && params[:friend_email] && params[:commit]
        already_invited = UserInvitee.find_by_user_id_and_friend_email(session[:user_credentials_id],params[:friend_email])
        already_member = User.find_by_email(params[:friend_email])
        unless already_invited or already_member
         UserMailer.invitation(params).deliver
         UserInvitee.create(:user_id=> session[:user_credentials_id], :friend_name=>params[:friend_name],:friend_email=> params[:friend_email],:invitation_date=> Date.today,:invitation_status=> 'Pending' )
        end 
      end
  end

end
