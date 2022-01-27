# This file is copied to spec/ when you run 'rails generate rspec:install'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'spec_helper'

# ActiveRecord::Migration.maintain_test_schema!

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

module ResponseJSON
  def response_json
    JSON.parse(response.body)
  end
end

module ResultsJSON
  def results_json
    response_json['results']
  end
end

module ClassificationJSON
  def classic_json
    results_json['classifications']
  end
end

module EvaluationJSON
  def eval_json
    eval(classic_json)
  end
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
  config.include ResponseJSON
  config.include ResultsJSON
  config.include EvaluationJSON
  config.include ClassificationJSON
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
