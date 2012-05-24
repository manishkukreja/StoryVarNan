class Book < ActiveRecord::Base
  attr_accessible :image, :audio, :name, :description, :notes,:published_at,:position, :permalink,:image_link
  has_many :taggings
  has_many :tags, :through => :taggings
  mount_uploader :image, ImageUploader
  mount_uploader :audio, AudioUploader
  has_many :comments
  has_many :languages
  
  scope :published, lambda { where('published_at <= ?', Time.now.utc) }
  scope :unpublished, lambda { where('published_at > ?', Time.now.utc) }
  scope :tagged, lambda { |tag_id| tag_id ? joins(:taggings).where(:taggings => {:tag_id => tag_id}) : scoped }
  scope :recent, order('position DESC')
  
  
  
  
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
  
  def self.search_published(query, tag_id = nil)
    if APP_CONFIG['thinking_sphinx']
      with = tag_id ? {:tag_ids => tag_id.to_i} : {}
      
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
      self.class.published.limit(5).primitive_search(name, "OR")
    end
  rescue ThinkingSphinx::ConnectionError => e
    APP_CONFIG['thinking_sphinx'] = false
    raise e
  end
  ##Method ends for similer books ##
  
end
