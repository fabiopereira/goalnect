source 'https://rubygems.org'

group :production, :staging, :demo do
  gem 'pg'
end

group :development, :test do
  gem 'mailcatcher'
  gem 'heroku_san'
  gem 'steak'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'capybara-screenshot'
end

group :test do
  gem "database_cleaner", ">= 0.7.2"
  gem 'factory_girl_rails', "~> 4.0"
  gem 'email_spec'  
end

gem 'thin'
gem 'rails', '3.2.3'
gem 'devise', '2.1.0'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'oauth2'
gem 'google-analytics-rails'
gem 'sprockets-image_compressor'  
gem 'active_hash'      
gem 'carrierwave'
gem 'rmagick'
gem 'bootstrap-wysihtml5-rails'
gem "opinio"

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platform => :ruby

  gem 'uglifier', '>= 1.0.3'
  #gem 'twitter-bootstrap-rails' 
  #gem 'execjs'
  #gem 'therubyracer', :platform => :ruby
  gem 'twitter-bootstrap-rails'
  
end
gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem "kaminari"
