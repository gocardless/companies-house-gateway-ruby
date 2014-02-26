require 'spec_helper'

describe CompaniesHouseGateway::Checks::OfficerDetails do
  describe "#perform" do
    let(:check_data) { { person_id: "alsdkj123", user_reference: 1 } }

    it_behaves_like "it generates valid xml"
    it_behaves_like "it returns only the body of the response"
    it_behaves_like "it validates presence", :person_id
  end
end
