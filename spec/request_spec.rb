require 'spec_helper'

describe CompaniesHouseGateway::Request do
  let(:request) { CompaniesHouseGateway::Request.new(connection, config) }
  let(:config) { CompaniesHouseGateway::Config.new }
  let(:connection) do
    CompaniesHouseGateway::Client.new(config).send(:connection)
  end

  let(:response_hash) { { status: status, body: body } }
  let(:status) { 200 }
  let(:body) { load_fixture('response.xml') }
  before do
    stub_request(:post, config[:api_endpoint]).to_return(response_hash)
  end

  let(:request_type) { :name_search }
  let(:request_data) { {} }

  describe '#build_request_xml' do
    subject(:request_xml) do
      request.build_request_xml(request_type, request_data)
    end
    let(:xml_schema) { load_fixture('request.xsd') }
    let(:xsd) { Nokogiri::XML::Schema(xml_schema) }

    it "generates a valid XML request" do
      xsd.validate(request_xml).should == []
    end

    context "with an email address" do
      before { config[:email] = "grey@gocardless.com" }

      it "generates a valid XML request" do
        xsd.validate(request_xml).should == []
      end
    end
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
      it { should include "GovTalkMessage" }

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

        context "200 with an error from Companies House" do
          let(:body) { load_fixture('bad_response.xml') }

          it "wraps the error" do
            expect { perform_check }.
              to raise_error(
                CompaniesHouseGateway::APIError, "(604) Error text")
          end
        end

        context "200 with unexpected XML" do
          let(:body) { "<TopLevel></TopLevel>" }

          it "wraps the error" do
            expect { perform_check }.
              to raise_error CompaniesHouseGateway::InvalidResponseError
          end
        end
      end
    end
  end
end
