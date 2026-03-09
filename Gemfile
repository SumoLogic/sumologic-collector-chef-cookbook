# frozen_string_literal: true

source 'https://rubygems.org'

ruby '>= 3.1'

# Test Kitchen and drivers
gem 'bcrypt_pbkdf', '>= 1.1.1'
gem 'inspec-core', '~> 5.22.55'
gem 'kitchen-docker'
gem 'kitchen-inspec'
gem 'kitchen-vagrant'
gem 'test-kitchen', '~> 3.6'

# Chef tooling
gem 'berkshelf', '~> 7.0'
gem 'chef', '~> 17.0'

group :lint do
  gem 'foodcritic'
  gem 'rubocop'
end

group :unit do
  gem 'chefspec'
end
