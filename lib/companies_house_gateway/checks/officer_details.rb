module CompaniesHouseGateway
  module Checks
    class OfficerDetails
      include Check

      required_input :person_i_d,
                     :user_reference

      default_input continuation_key: nil
    end
  end
end
