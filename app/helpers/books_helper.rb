module BooksHelper
  
  def book_video_tag(book)
    video_tag book.asset_url("videos"), :poster => "{#@book.name.downcase#{800 if book.legacy?}}.png", :width => (book.legacy? ? 800 : 960), :height => 600
  end


  

end