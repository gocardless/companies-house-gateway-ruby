require 'spec_helper'

describe CompaniesHouseGateway::Checks::OfficerSearch do
  describe "#perform" do
    let(:check_data) { { surname: "Baker", officer_type: "DIS" } }

    it_behaves_like "it generates_valid_xml"
    it_behaves_like "it validates presence", :surname
  end
end
