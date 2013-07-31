module BooksHelper
  
  def book_video_tag(book)
    video_tag book.asset_url("videos"), :poster => "{#@book.name.downcase#{800 if book.legacy?}}.png", :width => (book.legacy? ? 800 : 960), :height => 600
  end

  def updated_category_filter(val)
  	return params[:tag_ids]-[val.id.to_s]
  end

  def updated_age_group_filter(val)
  	return params[:age_group_ids]-[val.id.to_s]
  end	

  

end