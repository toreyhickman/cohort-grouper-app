ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
require 'shoulda/matchers'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.infer_spec_type_from_file_location!
  config.order = :random
  config.infer_base_class_for_anonymous_controllers = false

  config.include FactoryGirl::Syntax::Methods
  config.include OmniAuthMacros
  config.include ValidateDevBootcampOwnerMacros
  config.include LoginMacros
  config.include RetrieveActiveCohortsMacros

  # Settings for DatabaseCleaner
  config.use_transactional_fixtures = false
  config.before(:suite) { DatabaseCleaner.strategy = :transaction }
  config.before(:each) do
    DatabaseCleaner.strategy = :truncation if Capybara.current_driver == :selenium
    DatabaseCleaner.start
  end
  config.after(:each)   { DatabaseCleaner.clean }
end

OmniAuth.config.test_mode = true
