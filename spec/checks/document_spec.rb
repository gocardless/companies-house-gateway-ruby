require 'spec_helper'

describe CompaniesHouseGateway::Checks::Document do
  describe "#perform" do
    let(:check_data) do
      { doc_request_key: "als123lkj123",
        user_reference: "REFERECE" }
    end

    it_behaves_like "it generates_valid_xml"
    it_behaves_like "it validates presence", :doc_request_key
  end
end
