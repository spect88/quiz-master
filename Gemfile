source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Server basics
gem 'rails', '~> 5.0.2'
gem 'pg'
gem 'redis'
gem 'puma', '~> 3.0'

# JS/CSS
gem 'bootstrap-sass', '~> 3.3.6'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'turbolinks', '~> 5'
gem 'react-rails'

# API
gem 'jbuilder', '~> 2.5'

# Session
gem 'redis-rails'
gem 'omniauth'
gem 'omniauth-auth0'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'json-schema'
  gem 'jasmine-rails'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

ruby '2.4.0'
