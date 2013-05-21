class LineItemsController < ApplicationController
  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @line_items }
    end
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/new
  # GET /line_items/new.json
  def new
    @line_item = LineItem.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @line_item }
    end
  end

  # GET /line_items/1/edit
  def edit
    @line_item = LineItem.find(params[:id])
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @reading_list = reading_list(params)
    @line_item = LineItem.find_or_create_by_reading_list_id_and_book_id_and_user_id(:reading_list_id => @reading_list.id,:book_id=> params[:book_id], :user_id => session[:user_credentials_id])
  
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to books_path, notice: 'Book is successfully added to your BookShelf.' }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.json
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    #raise params.inspect
    @line_item = LineItem.find(params[:id])
    #@line_item = LineItem.find_by_user_id_and_book_id_and_reading_list_id(session[:user_credentials_id],params[:format],session[:reading_list_id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to root_path,notice: 'Book is successfully removed from your BookShelf.' }
      format.json { head :ok }
    end
  end
end
