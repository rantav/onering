source 'http://rubygems.org'
#source 'http://production.cf.rubygems.org'

gem 'rails', '3.1.3'

gem 'twitter-bootstrap-rails'
gem 'formtastic'
gem 'formtastic-bootstrap'
gem 'haml'
gem 'meta_search', '>= 1.1.0.pre'
gem "devise", "~> 2.0"
gem "devise_ldap_authenticatable"
gem 'thin'
gem 'sass-rails', "  ~> 3.1.0" # why is this here and not in assets? see https://github.com/rails/sass-rails/issues/38
gem 'mongoid', '~> 2.4.10'
gem 'bson_ext'
gem 'csv-mapper'
gem 'mongoid_search'
gem 'best_in_place', '~> 1.1.0'
gem 'kaminari'
gem 'rails3-jquery-autocomplete'
gem "nested_form", :git => "git://github.com/ryanb/nested_form.git"
gem "high_voltage"
gem "rest-client", "~> 1.6.7"
gem "glu_client", :git => "git://github.com/rantav/glu_client.git"
gem 'rufus-scheduler'
gem 'chef', '~> 0.10.10'
gem "cancan"
gem 'stomp'

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
gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'rspec'
end
group :development, :test do
  gem 'watchr'
  gem "rspec-rails", "~> 2.6"
  gem 'spork-rails'
end
group :development do
  gem 'pry'
  gem 'pry-doc'
  gem 'haml-rails'
  gem 'quiet_assets'
end
