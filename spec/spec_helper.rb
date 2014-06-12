require 'companies_house_gateway'
require 'webmock/rspec'
require 'shared_examples'

RSpec.configure do |config|
  config.mock_with(:rspec) { |mocks| mocks.verify_partial_doubles = true }
  config.raise_errors_for_deprecations!
  config.include WebMock::API
end

def configure_companies_house_gateway
  CompaniesHouseGateway.configure { |config| config[:sender_id] = "Grey" }
end

def load_fixture(*filename)
  File.open(fixture_path(filename)).read
end

def fixture_path(*filename)
  File.join('spec', 'fixtures', *filename)
end

