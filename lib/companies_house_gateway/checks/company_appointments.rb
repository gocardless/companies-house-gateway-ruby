module CompaniesHouseGateway
  module Checks
    class CompanyAppointments
      include Check

      required_input :company_number

      default_input company_name: "-",            # Required but not used...
                    continuation_key: nil,
                    include_resigned_ind: false,
                    user_reference: "REFERENCE"
    end
  end
end
