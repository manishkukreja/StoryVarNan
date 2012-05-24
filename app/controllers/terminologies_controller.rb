class TerminologiesController < ApplicationController
  # GET /terminologies
  # GET /terminologies.xml
  def index
    @terminologies = Terminology.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @terminologies }
    end
  end

  # GET /terminologies/1
  # GET /terminologies/1.xml
  def show
    @terminology = Terminology.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @terminology }
    end
  end

  # GET /terminologies/new
  # GET /terminologies/new.xml
  def new
    @terminology = Terminology.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @terminology }
    end
  end

  # GET /terminologies/1/edit
  def edit
    @terminology = Terminology.find(params[:id])
  end

  # POST /terminologies
  # POST /terminologies.xml
  def create
    @terminology = Terminology.new(params[:terminology])

    respond_to do |format|
      if @terminology.save
        format.html { redirect_to(@terminology, :notice => 'Terminology was successfully created.') }
        format.xml  { render :xml => @terminology, :status => :created, :location => @terminology }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @terminology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /terminologies/1
  # PUT /terminologies/1.xml
  def update
    @terminology = Terminology.find(params[:id])

    respond_to do |format|
      if @terminology.update_attributes(params[:terminology])
        format.html { redirect_to(@terminology, :notice => 'Terminology was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @terminology.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /terminologies/1
  # DELETE /terminologies/1.xml
  def destroy
    @terminology = Terminology.find(params[:id])
    @terminology.destroy

    respond_to do |format|
      format.html { redirect_to(terminologies_url) }
      format.xml  { head :ok }
    end
  end
end
