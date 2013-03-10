class InfoController < ApplicationController
  
  
  def index
    
  end
  
  def show
    #@narrator_list = Book.find_narrator(params)
     @other_books = Book.find_all_by_narrator(params[:id])
     
    render layout: false
  end
  
  
  def about
  end

  def give_back
  end
end
