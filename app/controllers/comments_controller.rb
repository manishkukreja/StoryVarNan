class CommentsController < ApplicationController
#before_filter :require_user
  before_filter :logging_required

  def index
    if is_user_admin?
      @comments_grid = initialize_grid(Comment,
      :include => [:book]
      )
    else
      @comments_grid = initialize_grid(Comment.where(:user_id => session[:user_credentials_id].to_s),
      :include => [:book,:user]
      )
    end 
    render :my_comments
    # respond_to do |format|
    #   format.html  
    #   #format.xml  { render :xml => @comments }
    # end
  end

 

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new(:parent_id => params[:parent_id],:book_id => params[:book_id], :user => current_user)
    respond_to do |format|
      format.html 
      format.xml  { render :xml => @comment }
    end
end

  def edit
    @comment = Comment.find(params[:id])
  end


 
  def create 
    @comment = current_user.comments.build(params[:comment])
    @comment.request = request
    @comment.save 
     respond_to do |format|
       format.html do
         if @comment.errors.present?
           render :new
         else
           @comment.notify_other_commenters
           redirect_to(book_path(@comment.book, :view => "comments"))
         end
        end 
       end
       
       #format.js 
     end
   
  
  
  def update
    @comment = Comment.find(params[:id])
    @comment.update_attributes(params[:comment])
    respond_to do |format|
      format.html do
        if @comment.errors.present?
          render :edit
        else
          redirect_to(book_path(@comment.book, :view => "comments"))
        end
      end
      format.js
    end
  end

  # def destroy
  #   # @comment.destroy

  #   flash[:notice] = "Deleted comment. #{undo_link}"
  #   respond_to do |format|

  #     format.html { redirect_to book_path(@comment.book, :view => "books/comments") }
  #     format.js
  #   end
  # end

def destroy
    @comment = Comment.find(params[:id])
    book_id= @comment.book_id
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to book_path(book_id,:view => "comments") }
      format.json { head :no_content }
    end
  end


  private

  def undo_link
    if can? :revert, :versions
      version = @comment.versions.scoped.last
      view_context.link_to("undo", revert_version_path(version), :method => :post) if can? :revert, version
    end
  end

  
end

