require 'spec_helper'

describe CompaniesHouseGateway::Checks::OfficerSearch do
  describe "#perform" do
    let(:check_data) { { surname: "Baker", officer_type: "DIS" } }

    it_behaves_like "it generates valid xml"
    it_behaves_like "it returns only the body of the response"
    it_behaves_like "it validates presence", :surname
  end
end
