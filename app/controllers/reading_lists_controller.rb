class ReadingListsController < ApplicationController
  # GET /reading_lists
  # GET /reading_lists.json
  def index
    @reading_lists = ReadingList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reading_lists }
    end
  end

  # GET /reading_lists/1
  # GET /reading_lists/1.json
  def show
    @reading_list = LineItem.find_all_by_user_id(session[:user_credentials_id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reading_list }
    end
  end

  # GET /reading_lists/new
  # GET /reading_lists/new.json
  def new
    @reading_list = ReadingList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @reading_list }
    end
  end

  # GET /reading_lists/1/edit
  def edit
    @reading_list = ReadingList.find(params[:id])
  end

  # POST /reading_lists
  # POST /reading_lists.json
  def create
    @reading_list = ReadingList.new(params[:reading_list])

    respond_to do |format|
      if @reading_list.save
        format.html { redirect_to @reading_list, notice: 'Reading list was successfully created.' }
        format.json { render json: @reading_list, status: :created, location: @reading_list }
      else
        format.html { render action: "new" }
        format.json { render json: @reading_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reading_lists/1
  # PUT /reading_lists/1.json
  def update
    @reading_list = ReadingList.find(params[:id])

    respond_to do |format|
      if @reading_list.update_attributes(params[:reading_list])
        format.html { redirect_to @reading_list, notice: 'Reading list was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reading_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reading_lists/1
  # DELETE /reading_lists/1.json
  def destroy
    @reading_list = ReadingList.find(params[:id])
    @reading_list.destroy

    respond_to do |format|
      format.html { redirect_to reading_lists_url }
      format.json { head :ok }
    end
  end
end
