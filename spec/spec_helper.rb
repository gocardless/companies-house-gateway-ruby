require 'companies_house_gateway'
require 'webmock/rspec'
RSpec.configure { |config| config.include WebMock::API }

def configure_companies_house_gateway
  CompaniesHouseGateway.configure { |config| config[:sender_id] = "Grey" }
end

def load_fixture(*filename)
  File.open(File.join('spec', 'fixtures', *filename)).read
end
