#
# Application Template
#

repo_url = "https://github.com/saboyutaka/rails4_template"

@app_name = app_name

def get_and_gsub(source_path, local_path)
  get source_path, local_path

  gsub_file local_path, /%app_name%/, @app_name
  gsub_file local_path, /%app_name_classify%/, @app_name.classify
end

# Gemfile
remove_file 'Gemfile'
get "#{repo_url}/Gemfile", "Gemfile"

# Bundle install
run "bundle install"

# use Rspec instead of TestUnit
remove_dir 'test'

# .gitignore
remove_file '.gitignore'
get "#{repo_url}/gitignore", '.gitignore'

# erb to slim
remove_file "app/views/layouts/application.html.erb"
get "#{repo_url}/application.html.slim", 'app/views/layouts/application.html.slim'

# .rubocop.yml
get "#{repo_url}/rubocop.yml", '.rubocop.yml'


# config/application.rb
# insert_into_file "config/application.rb",
#                  %(    config.autoload_paths += Dir[Rails.root.join('lib')]\n),
#                  after: "# Custom directories with classes and modules you want to be autoloadable.\n"

# insert_into_file "config/application.rb",
#                  %(    config.i18n.default_locale = :ja\n),
#                  after: "# config.i18n.default_locale = :de\n"

# insert_into_file "config/application.rb",
#                  %(    config.autoload_paths += Dir[Rails.root.join('app', 'models')]\n),
#                  after: "# Custom directories with classes and modules you want to be autoloadable.\n"

# insert_into_file "config/application.rb",
#                  %(    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]\n),
#                  after: "# The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.\n"

# insert_into_file "config/environments/production.rb",
#                  %(  config.action_controller.page_cache_directory = Rails.root.join("public", "system", "cache")\n),
#                  after: "# config.cache_store = :mem_cache_store\n"

# insert_into_file "config/environments/production.rb",
#                  %(  config.assets.static_cache_control = "public, max-age=#{60 * 60 * 24}"\n),
#                  after: "# config.cache_store = :mem_cache_store\n"


# rspec
generate 'rspec:install'

#
# Git
#
git :init
git :add => '.'
git :commit => '-am "Initial commit"'

