# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.infer_spec_type_from_file_location!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.filter_rails_from_backtrace!

  config.fixture_path = Rails.root.join('spec', 'fixtures').to_s

  config.global_fixtures = :all
  config.use_transactional_fixtures = true

  # config.include(Devise::Test::ControllerHelpers, type: :controller)
  # config.include(Devise::Test::ControllerHelpers, type: :view)
  # config.include(HandleExceptionsInSpecs, type: :controller)
  # config.include(ActiveStorage::Helpers)

  # config.before { ActiveStorage::Blob.service.reset! }
end

