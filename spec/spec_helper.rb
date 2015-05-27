require 'is_rateable'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../dummy/config/environment', __FILE__)
require 'rspec/rails'
require 'factory_girl_rails'
require 'pry'

if defined?(ActiveRecord::Migration.maintain_test_schema!)
  ActiveRecord::Migration.maintain_test_schema!
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
end
