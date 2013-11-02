source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.0.0'

# MySQL
gem 'mysql2'

# Assets
gem 'slim'
gem 'sass-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 1.2'
gem 'turbolinks'

# Internationalization
# gem 'rails-i18n'

# User Authentication
# gem 'devise'

# Profiler
gem 'rack-mini-profiler'

group :development, :test do
  # Web Server
  gem 'puma'

  # Rails Generator Helper
  gem 'slim-rails'

  # Testing
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'ffaker' # Generates dummy names
  gem 'capybara'
  gem 'launchy'

  # Deploy
  gem 'capistrano'

  # Debugger
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
end

group :development do
  # Rails Generator Helper
  gem 'slim-rails'

  # Guard
  gem 'guard'
  gem 'guard-rspec'
  gem 'spring'
  gem 'guard-spring'
  gem 'guard-rubocop'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'quiet_assets'
  gem 'letter_opener'
  gem 'mail_view'
end

group :test do
  gem 'simplecov', require: false
  gem 'shoulda-matchers'
  gem 'database_cleaner'
  gem 'poltergeist'
end
