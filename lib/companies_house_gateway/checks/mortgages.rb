module CompaniesHouseGateway
  module Checks
    class Mortgages
      include Check

      required_input :company_number

      default_input company_name: "-",            # Required but not used...
                    user_reference: "REFERENCE",
                    satisfied_charges_ind: false,
                    start_date: nil,
                    end_date: nil,
                    continuation_key: nil
    end
  end
end
