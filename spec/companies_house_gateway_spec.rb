require 'spec_helper'

describe CompaniesHouseGateway do
  before { CompaniesHouseGateway.instance_variable_set(:@config, nil) }

  describe '#configure' do
    subject { CompaniesHouseGateway.config }
    CompaniesHouseGateway::Config::DEFAULT_OPTIONS.keys.each do |key|
      context "setting #{key}" do
        before do
          CompaniesHouseGateway.configure { |config| config[key] = key }
        end
        its([key]) { should == key }
      end
    end
  end

  describe "#config" do
    subject(:config) { CompaniesHouseGateway.config }

    it "raises an error if CompaniesHouseGateway hasn't been configured" do
      expect { config }.
        to raise_error CompaniesHouseGateway::CompaniesHouseGatewayError
    end
  end

  describe '#perform_check' do
    before { configure_companies_house_gateway }
    let(:data) { "data" }

    it "delegates to the client" do
      CompaniesHouseGateway::Client.any_instance.
        should_receive(:perform_check).with(data)
      CompaniesHouseGateway.perform_check(data)
    end
  end

  describe '#name_search' do
    before { configure_companies_house_gateway }
    let(:data) { "data" }

    it "delegates to the client" do
      CompaniesHouseGateway::Client.any_instance.
        should_receive(:name_search).with(data)
      CompaniesHouseGateway.name_search(data)
    end
  end

  describe '#company_appointments' do
    before { configure_companies_house_gateway }
    let(:data) { "data" }

    it "delegates to the client" do
      CompaniesHouseGateway::Client.any_instance.
        should_receive(:company_appointments).with(data)
      CompaniesHouseGateway.company_appointments(data)
    end
  end
end
