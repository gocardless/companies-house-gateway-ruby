module CompaniesHouseGateway
  module Checks
    class Mortgages
      include Check

      required_input :company_name,
                     :company_number,
                     :user_reference

      default_input satisfied_charges_ind: false,
                    start_date: nil,
                    end_date: nil,
                    continuation_key: nil
    end
  end
end
