# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ActiveSupport::Deprecation.silenced = true
Bookshelf::Application.initialize!

# config.gem(
  # 'thinking-sphinx', :version => '1.4.10'
# )


