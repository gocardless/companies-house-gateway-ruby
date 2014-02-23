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

      its(:config) { should_not == CompaniesHouseGateway.config }
      it "has the attributes of the global config" do
        new_client.config[:sender_id] ==
          CompaniesHouseGateway.config[:sender_id]
      end
    end

    context "with a config" do
      before { config[:first_name] = "test" }
      subject(:new_client) { CompaniesHouseGateway::Client.new(config) }

      its(:config) { should_not == config }
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
  end

  it_behaves_like "it delegates to the check", :name_search
  it_behaves_like "it delegates to the check", :number_search
  it_behaves_like "it delegates to the check", :company_appointments
  it_behaves_like "it delegates to the check", :company_details
  it_behaves_like "it delegates to the check", :officer_search
  it_behaves_like "it delegates to the check", :officer_details
end
