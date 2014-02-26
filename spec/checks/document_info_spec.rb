require 'spec_helper'

describe CompaniesHouseGateway::Checks::DocumentInfo do
  describe "#perform" do
    let(:check_data) do
      { company_number: "07495895",
        company_name: "GoCardless",
        image_key: "asd121a" }
    end

    it_behaves_like "it generates valid xml"
    it_behaves_like "it returns only the body of the response"
    it_behaves_like "it validates presence", :company_name
    it_behaves_like "it validates presence", :company_number
    it_behaves_like "it validates presence", :image_key
  end
end
