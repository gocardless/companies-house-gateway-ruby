require 'spec_helper'

describe CompaniesHouseGateway::Checks::CompanyAppointments do
  let(:company_appointments) do
    CompaniesHouseGateway::Checks::CompanyAppointments.new(client)
  end
  let(:client) { CompaniesHouseGateway::Client.new(config) }
  let(:config) { CompaniesHouseGateway::Config.new }

  let(:response_hash) { { status: status, body: body } }
  let(:status) { 200 }
  let(:body) { "<XML></XML>" }
  before do
    stub_request(:post, config[:api_endpoint]).to_return(response_hash)
  end

  describe "#perform" do
    subject(:perform_check) { company_appointments.perform(check_data) }

    let(:check_data) do
      { company_number: "07495895",
        company_name: "GoCardless",
        user_reference: "ABC" }
    end

    it "makes a get request" do
      perform_check
      a_request(:post, config[:api_endpoint]).should have_been_made
    end

    describe "validates inputs" do
      it_behaves_like "it validates presence", :company_number
      it_behaves_like "it validates presence", :company_name
      it_behaves_like "it validates presence", :user_reference
    end
  end
end
