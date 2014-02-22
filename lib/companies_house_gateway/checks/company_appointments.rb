module CompaniesHouseGateway
  module Checks
    class CompanyAppointments
      include Check

      required_input :company_name,
                     :company_number,
                     :user_reference

      default_input continuation_key: nil,
                    include_resigned_ind: false
    end
  end
end
