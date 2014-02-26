require 'spec_helper'

describe CompaniesHouseGateway::Checks::FilingHistory do
  describe "#perform" do
    let(:check_data) { { company_number: "07495895" } }

    it_behaves_like "it generates valid xml"
    it_behaves_like "it returns only the body of the response"
    it_behaves_like "it validates presence", :company_number
  end
end
