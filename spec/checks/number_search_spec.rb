require 'spec_helper'

describe CompaniesHouseGateway::Checks::NumberSearch do
  let(:number_search) do
    CompaniesHouseGateway::Checks::NumberSearch.new(client)
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
    subject(:perform_check) { number_search.perform(check_data) }

    let(:check_data) { { partial_company_number: "07495895" } }

    it "makes a get request" do
      perform_check
      a_request(:post, config[:api_endpoint]).should have_been_made
    end

    describe "validates inputs" do
      it_behaves_like "it validates presence", :partial_company_number
    end
  end
end
