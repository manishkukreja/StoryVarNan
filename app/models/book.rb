class Book < ActiveRecord::Base

  attr_accessible :image, :audio, :name, :description, :notes,:published_at,:position, :permalink,
                  :image_link,:comments_count, :legacy, :remote_audio_url, :file_sizes,:language_id,
                  :narrator,:flash_video

  has_many :taggings,:dependent => :destroy
  has_many :tags, :through => :taggings ,:dependent => :destroy
  mount_uploader :image, ImageUploader
  mount_uploader :audio, AudioUploader
  mount_uploader :flash_video, FlashVideoUploader
  has_many :comments, :dependent => :destroy
  has_many :languages
  has_many :line_items
  has_one :age_group
  letsrate_rateable "audio", "video", "overall"
  accepts_nested_attributes_for :taggings
  
  scope :published, lambda { where('published_at <= ?', Time.now.utc) }
  scope :unpublished, lambda { where('published_at > ?', Time.now.utc) }
  scope :tagged, lambda { |tag_id| tag_id ? joins(:taggings).where(:taggings => {:tag_id => tag_id}) : scoped }
  scope :recent, order('position DESC')
  scope :books_list, lambda{|book| book ? {:conditions=> ['id != ? AND narrator = ? ',book.id , book.narrator]} : {} }
  #validates :name,:description,:notes,:narrator,:permalink,:image_link , :presence => true
  #validates :name ,:uniqueness => true
  
  
  
##Method to search based on Narrator
def self.find_narrator(params)
  Book.find_by_sql('select distinct narrator from books').map{|i| i.narrator}
end
##
###Method to search based on Tag , language ,age group and narrator
def self.find_book(params)
  where_sql=['id > 0']

  if params[:language_id]
    where_sql= ["language_id = ?"]
    where_sql << params[:language_id]
  end

  if params[:narrator]
    if params[:language_id] || params[:tag_id] || params[:age_group_ids]
      where_sql[0] += " AND narrator = ?"
    else
      where_sql[0]= "narrator = ? "
    end
    where_sql << params[:narrator]
  end

  if params[:age_group_ids]
    if params[:language_id] || params[:tag_id] || params[:narrator]
      where_sql[0] += "AND age_group_id IN (?)"
    else
      where_sql = ["age_group_id IN (?)"]
    end
    where_sql << params[:age_group_ids]
  end

  if params[:tag_ids]
    if params[:language_id] || params[:narrator] || params[:age_group_ids]
      where_sql[0] += "AND id IN (?)"
    else
      where_sql=["id IN (?)"]
    end
    @tag_list=Tagging.where(:tag_id=>params[:tag_ids]).select(:book_id)
    @book_list=Book.where(:id=>@tag_list)
    where_sql<<@book_list
  end

  Book.where(where_sql)
  
end
###  
  
  
  
  def self.search(search)
    if search
      find(:all, :conditionds => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end



########INDEX METHODS
 def published?
    published_at <= Time.zone.now
  end
  
  def asset_name
    [padded_position, permalink].join('-')
  end
  
  def padded_position
    position.to_s.rjust(3, "0")
  end
  
  
  def self.search_selected_books(params)
    
    @search_result = Book.find_by_sql("select * from Books where tag ")
    @search_result = Book.find(:all,:conditions=> {})
    
  end
  
  def self.search_published(query, tag_id = nil, language_id = nil)
    if APP_CONFIG['thinking_sphinx']
      with = tag_id ? {:tag_ids => tag_id.to_i} : {}
      with = language_id ? {:language_ids => language_id.to_i} : {}
      search(query, :conditions => { :published_at => 0..Time.now.utc.to_i }, :with => with,
                    :field_weights => { :name => 20, :description => 15, :notes => 5, :tag_names => 10 })
    else
      published.primitive_search(query)
    end
  rescue ThinkingSphinx::ConnectionError => e
    APP_CONFIG['thinking_sphinx'] = false
    raise e
  end

  def self.primitive_search(query, join = "AND")
    where(primitive_search_conditions(query, join))
  end
  
  def self.primitive_search_conditions(query, join)
    query.split(/\s+/).map do |word|
      '(' + %w[name description notes].map { |col| "#{col} LIKE #{sanitize('%' + word.to_s + '%')}" }.join(' OR ') + ')'
    end.join(" #{join} ")
  end
  
  
  
########END OF INDEX METHODS  
  
   
#######Show Methods
def full_name
    "\##{position} #{name}"
  end
  
  
  def last_published?
    self == self.class.published.last
  end
  
  def previous
    self.class.where("position < ?", position).order("position desc").first
  end

  def next
    self.class.where("position > ?", position).order("position").first
  end
  
  def padded_position
    position.to_s.rjust(3, "0")
  end
  
  def asset_name
    [padded_position, permalink].join('-')
  end
  
  def asset_url(path, ext = nil)
    #"/public/uploads/book/#{path}/#{asset_name}" + (ext ? ".#{ext}": "")
    #@book.audio_url
    #"http://media.railscasts.com/assets/episodes/#{path}/#{asset_name}" + (ext ? ".#{ext}" : "")
    "https://s3.amazonaws.com/bookshelf_audio/#{asset_name}" + (ext ? ".#{ext}" : "")
  end
  
#######  
  ##Method for similer books##
  def similar_books
    if APP_CONFIG['thinking_sphinx']
      self.class.search("#{name} #{tag_names}", :without_ids => [id],
            :conditions => { :published_at => 0..Time.now.utc.to_i },
            :match_mode => :any, :page => 1, :per_page => 5,
            :field_weights => { :name => 20, :description => 15, :notes => 5, :tag_names => 10 })
    else
      raise params.inspect
      exit
      self.class.published.limit(5).primitive_search(name, "OR")
    end
  rescue ThinkingSphinx::ConnectionError => e
    APP_CONFIG['thinking_sphinx'] = false
    raise e
  end
  ##Method ends for similer books ##


  def same_books(val)
    tag_list  = Tagging.where(:book_id => val.id).select('tag_id')
    book_list = Tagging.where(:tag_id=>tag_list).select(:book_id)
    book_ids  = Book.where(:id=>book_list).select('id')
    #book_ids = book_ids - [val.id]
    same_books=[]
    same_books =  ['language_id in (?) AND age_group_id in (?) OR id in (?)']
    same_books << val.language_id
    same_books << val.age_group_id
    same_books << book_ids
    Book.where(same_books).except(:id => val.id)
  end
  
end