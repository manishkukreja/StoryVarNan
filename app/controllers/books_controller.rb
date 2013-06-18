 class BooksController < ApplicationController
  before_filter :logging_required ,:except=> [:index,:show]

  
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
    @other_books = Book.books_list(@book)
    if params[:id] != @book.to_param   # Not understood 
      headers["Status"] = "301 Moved Permanently"
      redirect_to book_url(@book)
    else
      @comment = Comment.new(:book_id => @book.id, :user_id => current_user)
    end
  end

  def new
    @book = Book.new
    @categories_list =  Tag.all
    @narrator_list = Book.find_narrator(params)
    @book.position = Book.maximum(:position).to_i + 1
  
  end


  def edit
    @book = Book.find(params[:id])

  end

  def create
    if params[:book][:narrator].eql?("Other")
      params[:book][:narrator] = params[:temp_narrator_name]
    end
    @book = Book.new(params[:book])
    respond_to do |format|
      if @book.save
        create_tagging(@book.id)
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
      when  nil   then 5
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

  def create_tagging(var)
    if params[:tag_ids].count > 1
      params[:tag_ids].each {|tag|
        @tagging = Tagging.create(:book_id => @book.id,:tag_id => tag)
      }
    else 
       @tagging = Tagging.create(:book_id => @book.id,:tag_id => params[:tag_ids].first)
    end   
  end

end
