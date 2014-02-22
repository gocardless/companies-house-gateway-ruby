require 'companies_house_gateway'
require 'webmock/rspec'
RSpec.configure { |config| config.include WebMock::API }

def configure_companies_house_gateway
  CompaniesHouseGateway.configure { |config| config[:sender_id] = "Grey" }
end

def load_fixture(*filename)
  File.open(File.join('spec', 'fixtures', *filename)).read
end

shared_examples "it validates presence" do |property|
  context "with a missing #{property}" do
    before { check_data.delete(property) }

    it "raises and error" do
      expect { subject }.
        to raise_error CompaniesHouseGateway::CompaniesHouseGatewayError
    end
  end
end