require 'companies_house_gateway'
require 'webmock/rspec'
require 'shared_examples'
RSpec.configure { |config| config.include WebMock::API }

def configure_companies_house_gateway
  CompaniesHouseGateway.configure { |config| config[:sender_id] = "Grey" }
end

def load_fixture(*filename)
  File.open(fixture_path(filename)).read
end

def fixture_path(*filename)
  File.join('spec', 'fixtures', *filename)
end

