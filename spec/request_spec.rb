require 'spec_helper'

describe CompaniesHouseGateway::Request do
  let(:request) { CompaniesHouseGateway::Request.new(connection, config) }
  let(:config) { CompaniesHouseGateway::Config.new }
  let(:connection) do
    CompaniesHouseGateway::Client.new(config).send(:connection)
  end

  let(:response_hash) { { status: status, body: body } }
  let(:status) { 200 }
  let(:body) { "<Results><Errors/></Results>" }
  before { stub_request(:post, config[:api_endpoint]).to_return(response_hash) }

  let(:request_type) { :name_search }
  let(:request_data) { {} }

  describe '#build_request_xml' do
    subject(:build_request_xml) do
      request.build_request_xml(request_type, request_data).to_s
    end
    let(:request_xml) { load_fixture('request.xml') }

    pending { should == request_xml }
  end

  describe "#perform" do
    subject(:perform_check) { request.perform(request_type, request_data) }

    it "makes a get request" do
      perform_check
      a_request(:post, config[:api_endpoint]).should have_been_made
    end

    context "when the config[:raw] is true" do
      before { config[:raw] = true }
      it { should be_a Faraday::Response }
      its(:body) { should be_a String }
    end

    context "when the config[:raw] is false" do
      it { should be_a Hash }
      it { should include "Results" }

      context "errors" do
        context "500" do
          let(:status) { 500 }

          it "wraps the error" do
            expect { perform_check }.
              to raise_error CompaniesHouseGateway::CompaniesHouseGatewayError
          end
        end

        context "400" do
          let(:status) { 400 }

          it "wraps the error" do
            expect { perform_check }.
              to raise_error CompaniesHouseGateway::CompaniesHouseGatewayError
          end
        end
      end
    end
  end
end
