module CompaniesHouseGateway
  module Checks
    class FilingHistory
      include Check

      required_input :company_number

      default_input capital_doc_ind: false,
                    continuation_key: nil
    end
  end
end
