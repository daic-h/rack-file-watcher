require "rubygems"
require "bundler/setup"

require "rack"
require "rack/test"
require "rack/file_watcher"

require "rspec"

module AppSpecHelper
  include Rack::Test::Methods

  TEST_FILE = File.expand_path('../support/test.txt', __FILE__)

  def app
    Rack::Builder.new {
      use Rack::FileWatcher, TEST_FILE do
        print 'Updated.'
      end
      run ->(env) { [200, {}, ['Hello World']] }
    }.to_app
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!
  config.warnings = false

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  config.include AppSpecHelper
end
