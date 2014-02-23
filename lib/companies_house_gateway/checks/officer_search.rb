module CompaniesHouseGateway
  module Checks
    class OfficerSearch
      include Check

      required_input :surname,
                     :officer_type

      default_input forename: nil,
                    post_town: nil,
                    country_of_residence: nil,
                    continuation_key: nil,
                    include_resigned_ind: false
    end
  end
end
