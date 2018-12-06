source 'https://rubygems.org'

gem 'dotenv-rails', groups: [:development, :test]

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.5.1'
# ruby '2.3.3'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# gem 'rails', '~> 5.0.1'
# Use postgresql as the database for Active Record
gem 'pg' #, '~> 0.15'
#gem 'sqlite3'

# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use thin as the app server (ssl)
#group :development do
#gem "thin"
#end

# Use SCSS for stylesheets
gem 'sassc'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# bundle exec rake doc:rails generates the API under doc/api.
#gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "nested_form"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'devise'

gem 'geocoder'

gem 'mini_magick', '3.8.0' # for creating thumbs

gem 'bootstrap-sass', '~> 3.2.0'
gem 'autoprefixer-rails'

gem 'bootstrap_form'

## Gemfile for Rails 3+, Sinatra, or Merb
gem 'will_paginate', '~> 3.0.5'
gem 'will_paginate-bootstrap'


# foreman for environment and procfile stuff
group :development, :test do
  gem 'foreman'
end

gem 'cocoon'

gem 'mail_form'
gem 'simple_form'
gem 'country_select'

gem 'haml'

gem "recaptcha", require: "recaptcha/rails"

group :development do
  gem 'rails_real_favicon'
end
