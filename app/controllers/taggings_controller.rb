class TaggingsController < ApplicationController
  
  def index
    
    @taggings = Tagging.all
    
    
  end

  def edit
    @tagging  = Tagging.find(params[:id])
  end

  def show
  end

  def new
    @tagging = Tagging.new
  end


def create
    @tagging = Tagging.new(params[:tagging])

    respond_to do |format|
      if @tagging.save
        format.html { redirect_to(@tagging, :notice => 'Tagging was successfully created.') }
        format.xml  { render :xml => @tagging, :status => :created, :location => @tagging }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tagging.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
  end

end
