module CompaniesHouseGateway
  module Checks
    class OfficerDetails
      include Check

      required_input :person_id

      default_input user_reference: "REFERENCE",
                    continuation_key: nil

    end
  end
end
