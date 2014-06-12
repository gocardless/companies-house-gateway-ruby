require 'spec_helper'

shared_examples "it delegates to the check" do |method_name|
  it "delegates #{method_name} to " +
     "#{CompaniesHouseGateway::Util.camelize(method_name)}" do
    expect_any_instance_of(CompaniesHouseGateway::Checks.
      const_get(CompaniesHouseGateway::Util.camelize(method_name))).
      to receive(:perform).once
    client.send(method_name, {})
  end
end

describe CompaniesHouseGateway::Client do
  let(:client) { CompaniesHouseGateway::Client.new(config) }
  let(:config) { CompaniesHouseGateway::Config.new }

  describe "#new" do
    context "without a config" do
      before { configure_companies_house_gateway }
      subject(:new_client) { CompaniesHouseGateway::Client.new }

      describe '#config' do
        subject { super().config }
        it { should_not == CompaniesHouseGateway.config }
      end
      it "has the attributes of the global config" do
        new_client.config[:sender_id] ==
          CompaniesHouseGateway.config[:sender_id]
      end
    end

    context "with a config" do
      before { config[:first_name] = "test" }
      subject(:new_client) { CompaniesHouseGateway::Client.new(config) }

      describe '#config' do
        subject { super().config }
        it { should_not == config }
      end
      it "has the attributes of the passed in config" do
        new_client.config[:sender_id] == config[:sender_id]
      end
    end
  end

  describe "#perform_check" do
    it "delegates to an instance of Request" do
      expect_any_instance_of(CompaniesHouseGateway::Request).
        to receive(:perform).once
      client.perform_check({})
    end

    context "if caching is enabled" do
      let(:cached_response) { double("Cached response") }
      let(:cache_stub) { double("Cache", fetch: cached_response) }
      before { config[:cache] = cache_stub }

      it "caches the request (if enabled)" do
        client.perform_check({}) == cached_response
      end
    end
  end

  it_behaves_like "it delegates to the check", :name_search
  it_behaves_like "it delegates to the check", :number_search
  it_behaves_like "it delegates to the check", :company_appointments
  it_behaves_like "it delegates to the check", :company_details
  it_behaves_like "it delegates to the check", :officer_search
  it_behaves_like "it delegates to the check", :officer_details
  it_behaves_like "it delegates to the check", :mortgages
  it_behaves_like "it delegates to the check", :filing_history
  it_behaves_like "it delegates to the check", :document_info
  it_behaves_like "it delegates to the check", :document
end
