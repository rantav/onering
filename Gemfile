source 'http://rubygems.org'
source 'http://production.cf.rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'twitter-bootstrap-rails'
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'haml'
#gem 'activeadmin'
gem 'meta_search', '>= 1.1.0.pre'
gem "devise_ldap_authenticatable"
gem 'thin'
gem 'sass-rails', "  ~> 3.1.0" # why is this here and not in assets? see https://github.com/rails/sass-rails/issues/38
gem 'mongoid'
gem 'bson_ext'
gem 'csv-mapper'
gem 'mongoid_search'
gem 'best_in_place', :git => 'git://github.com/rantav/best_in_place.git'
gem 'kaminari'
gem 'rails3-jquery-autocomplete'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'rspec'
end
group :development, :test do
  gem 'watchr'
  gem 'spork', '~> 0.9.0.rc'
end
group :development do
  gem 'pry'
  gem 'haml-rails'
end
