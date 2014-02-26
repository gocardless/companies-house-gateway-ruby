require 'spec_helper'

describe CompaniesHouseGateway::Checks::CompanyAppointments do
  describe "#perform" do
    let(:check_data) do
      { company_name: "GoCardless",
        company_number: "07495895",
        user_reference: "REFERECE" }
    end

    it_behaves_like "it generates valid xml"
    it_behaves_like "it returns only the body of the response"
    it_behaves_like "it validates presence", :company_number
    it_behaves_like "it validates presence", :company_name
  end
end
