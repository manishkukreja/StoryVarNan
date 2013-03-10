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



  def books_per_page
    case params[:view]
    when "list" then 10
    when "grid" then 4
    else 4
    end
  end
  
  

end
