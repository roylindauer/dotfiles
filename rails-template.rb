gem_group :development, :test do
  gem "debug" 

  # Optional other debugging tools
  # gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  # gem "pry-rails

  gem "annotate", "~> 3.2"
  gem "letter_opener_web", "~> 2.0"
  gem "standard", require: false
  gem "erb_lint", require: false

  # Security tooling to
  # gem "brakeman"
  # gem "bundler-audit", github: "rubysec/bundler-audit"

  # gem "simplecov", require: false

  # Testing
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails", "~> 6.0.0"

  # Rubocop
  gem "rubocop", "~> 1.39", require: false
  gem "rubocop-performance", "~> 1.15", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", "~> 2.14", require: false
end

gem_group :development do
  #gem 'guard', "~> 2.14", require: false
  #gem 'guard-rspec', "~> 4.7", require: false

  # A fully configurable and extendable Git hook manager
  gem "overcommit", require: false
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

generate "rspec:install"
#generate "tailwindcss:install"

rubocop_yml = <<-EOL
require: standard

inherit_gem:
  standard: config/base.yml
EOL

create_file ".rubocop.yml", rubocop_yml
