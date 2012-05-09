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

  def destroy
  end

end
