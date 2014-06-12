require 'spec_helper'

shared_examples "it delegates to the client" do |method_name|
  before { configure_companies_house_gateway }
  let(:data) { "data" }

  it "delegates #{method_name} to the client" do
    expect_any_instance_of(CompaniesHouseGateway::Client).
      to receive(method_name).with(data)
    CompaniesHouseGateway.send(method_name, data)
  end
end

describe CompaniesHouseGateway do
  before { CompaniesHouseGateway.instance_variable_set(:@config, nil) }

  describe '#configure' do
    subject { CompaniesHouseGateway.config }
    CompaniesHouseGateway::Config::DEFAULT_OPTIONS.keys.each do |key|
      context "setting #{key}" do
        before do
          CompaniesHouseGateway.configure { |config| config[key] = key }
        end

        describe [key] do
          subject { super()[key] }
          it { should == key }
        end
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

  it_behaves_like "it delegates to the client", :perform_check
  it_behaves_like "it delegates to the client", :name_search
  it_behaves_like "it delegates to the client", :number_search
  it_behaves_like "it delegates to the client", :company_appointments
  it_behaves_like "it delegates to the client", :company_details
  it_behaves_like "it delegates to the client", :officer_search
  it_behaves_like "it delegates to the client", :officer_details
  it_behaves_like "it delegates to the client", :mortgages
  it_behaves_like "it delegates to the client", :filing_history
  it_behaves_like "it delegates to the client", :document_info
  it_behaves_like "it delegates to the client", :document
end
