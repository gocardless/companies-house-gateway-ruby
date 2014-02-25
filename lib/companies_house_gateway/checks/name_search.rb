module CompaniesHouseGateway
  module Checks
    class NameSearch
      include Check

      required_input :company_name

      default_input  data_set: "LIVE",
                     same_as: false,
                     search_rows: 20,
                     continuation_key: nil,
                     regression_key: nil

    end
  end
end
