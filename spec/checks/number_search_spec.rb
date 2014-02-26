require 'spec_helper'

describe CompaniesHouseGateway::Checks::NumberSearch do
  describe "#perform" do
    let(:check_data) { { partial_company_number: "123", data_set: "LIVE" } }

    it_behaves_like "it generates valid xml"
    it_behaves_like "it returns only the body of the response"
    it_behaves_like "it validates presence", :partial_company_number
  end
end
