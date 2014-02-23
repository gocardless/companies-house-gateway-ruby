module CompaniesHouseGateway
  module Checks
    class CompanyDetails
      include Check

      required_input :company_number

      default_input give_mort_totals: false
    end
  end
end
