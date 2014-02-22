require 'spec_helper'

describe CompaniesHouseGateway::Client do
  let(:client) { CompaniesHouseGateway::Client.new(config) }
  let(:config) { CompaniesHouseGateway::Config.new }
  let(:check_data) { {} }

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
    subject(:perform_check) { client.perform_check(check_data) }

    it "delegates to an instance of Request" do
      expect_any_instance_of(CompaniesHouseGateway::Request).
        to receive(:perform).once
      client.perform_check(check_data)
    end
  end

  describe "#name_search" do
    subject(:name_search) { client.name_search(check_data) }

    it "delegates to an instance of NameSearch" do
      expect_any_instance_of(CompaniesHouseGateway::Checks::NameSearch).
        to receive(:perform).once
      client.name_search(check_data)
    end
  end

  describe "#number_search" do
    subject(:number_search) { client.number_search(check_data) }

    it "delegates to an instance of NumberSearch" do
      expect_any_instance_of(CompaniesHouseGateway::Checks::NumberSearch).
        to receive(:perform).once
      client.number_search(check_data)
    end
  end

  describe "#company_appointments" do
    subject(:company_appointments) { client.company_appointments(check_data) }

    it "delegates to an instance of CompanyAppointments" do
      expect_any_instance_of(
        CompaniesHouseGateway::Checks::CompanyAppointments).
        to receive(:perform).once
      client.company_appointments(check_data)
    end
  end
end
