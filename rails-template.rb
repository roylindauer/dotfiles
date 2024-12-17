gem_group :development, :test do
  # Optional other debugging tools
  # gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  # gem "pry-rails

  # incompatible with rails 8
  # lets move to https://github.com/drwl/annotaterb 
  # gem "annotate", "~> 3.2"
  gem "letter_opener_web", "~> 2.0"

  # Security tooling to
  # gem "brakeman"
  # gem "bundler-audit", github: "rubysec/bundler-audit"

  # gem "simplecov", require: false

  # Testing
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 6.0.0"
end

gem_group :development do
  #gem 'guard', "~> 2.14", require: false
  #gem 'guard-rspec', "~> 4.7", require: false

  # A fully configurable and extendable Git hook manager
  gem "overcommit", require: false

  # Rubocop
  #gem "rubocop-rails-omakase", require: false
end

gem_group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
#  gem "capybara", ">= 3.26"
#  gem "selenium-webdriver"
#  gem "webdrivers"

  # Clean database during tests
  gem "database_cleaner-active_record"
end

run "bundle install"

if yes? 'Do you wish to generate a root controller? (y/n)'
  name = ask('What do you want to call it?').to_s.underscore
  generate :controller, "#{name} show"
  route "root to: '#{name}\#show'"
  route "resource :#{name}, controller: :#{name}, only: [:show]"
end

rails_command "rspec:install"
rails_command "css:install:tailwind"
rails_command "javascript:install:esbuild"
rails_command "stimulus:install"
rails_command "turbo:install"

rubocop_yml = <<-EOL
require: standard

inherit_gem:
  rubocop-rails-omakase: rubocop.yml
EOL

create_file ".rubocop.yml", rubocop_yml

