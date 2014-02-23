require 'spec_helper'

describe CompaniesHouseGateway::Checks::CompanyDetails do
  describe "#perform" do
    let(:check_data) { { company_number: "07495895" } }

    it_behaves_like "it generates_valid_xml"
    it_behaves_like "it validates presence", :company_number
  end
end
