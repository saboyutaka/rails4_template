#
# Application Template
#

repo_url = "https://raw.github.com/saboyutaka/rails4_template/master"

@app_name = app_name
@app_name_upcase = app_name.upcase

# Gemfile
remove_file 'Gemfile'
get "#{repo_url}/Gemfile", "Gemfile"

# Bundle install
run "bundle install --binstubs='.bundle/bin' --path='./vendor/bundle'"

application <<GENERATORS
config.generators do |g|
   g.helper       false
   g.jbuilder     false
   g.assets       false
   g.test_framework :rspec, view_specs: false, request_specs: false
 end
GENERATORS

dev = <<-CODE
if ENV['#{@app_name_upcase}_LETTER_OPENER_ENABLE']
  config.action_mailer.delivery_method = :letter_opener
else
  # configure for mailcatcher
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: "localhost",
    port: (ENV['#{@app_name_upcase}_DEV_SMTP_PORT'] || 1025).to_i
  }
end
config.action_mailer.default_url_options = { host: "#{@app_name}.dev" }

Slim::Engine.set_default_options pretty: true, sort_attrs: false
CODE
environment dev, env: 'development'

# use Rspec instead of TestUnit
remove_dir 'test'

# .gitignore
remove_file '.gitignore'
get "#{repo_url}/.gitignore", '.gitignore'

# erb to slim
remove_file "app/views/layouts/application.html.erb"
get "#{repo_url}/application.html.slim", 'app/views/layouts/application.html.slim'

# Guardfile
get "#{repo_url}/Guardfile", 'Guardfile'

# .rubocop.yml
get "#{repo_url}/.rubocop.yml", '.rubocop.yml'

# database.yml
remove_file "config/database.yml"

file 'config/database.yml', <<CODE
common: &common
  adapter: mysql2
  encoding: utf8
  pool: 5
  username: <%= ENV['#{@app_name_upcase}_DBUSER'] || 'root' %>
  password: <%= ENV['#{@app_name_upcase}_DBPASS'] %>
  host: <%= ENV['#{@app_name_upcase}_DBHOST'] || 'localhost' %>
  port: <%= ENV['#{@app_name_upcase}_DBPORT'] %>

development:
  <<: *common
  database: #{@app_name}_development

test:
  <<: *common
  database: #{@app_name}_test

production:
  <<: *common
  database: #{@app_name}_production
CODE

# Initializers

initializer 'better_errors.rb', <<CODE
BetterErrors.editor = :sublime if Rails.env.development? && ENV['#{@app_name_upcase}_BETTER_ERRORS_EDITOR_SUBLIME']
CODE

initializer 'mini_profiler.rb', <<CODE
if ENV['#{@app_name_upcase}_PROFILER_DISABLE'] == '1'
  Rack::MiniProfiler.config.auto_inject = false
elsif ENV['#{@app_name_upcase}_PROFILER_HIDDEN'] != '1'
  Rack::MiniProfiler.config.start_hidden = true
end
CODE

# rspec
generate 'rspec:install'

if yes?("Do you want to use POW?")
  file '.powenv', <<-CODE
export #{@app_name_upcase}_BETTER_ERRORS_EDITOR_SUBLIME='1'
export #{@app_name_upcase}_PROFILER_DISABLE='1'
CODE

  run "powder link"
end

#
# Git
#
git :init
git :add => '.'
git :commit => '-am "Initial commit"'
