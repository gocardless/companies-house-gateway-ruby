module CompaniesHouseGateway
  module Checks
    class DocumentInfo
      include Check

      required_input :company_number,
                     :image_key

      default_input company_name: "-"             # Required but not used...
    end
  end
end
