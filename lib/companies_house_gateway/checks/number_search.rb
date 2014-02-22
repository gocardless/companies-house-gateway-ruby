module CompaniesHouseGateway
  module Checks
    class NumberSearch
      include Check

      required_input :partial_company_number,
                     :data_set

      default_input data_set: "LIVE",
                    search_rows: 20
    end
  end
end
