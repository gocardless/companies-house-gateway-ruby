module CompaniesHouseGateway
  module Checks
    class DocumentInfo
      include Check

      required_input :company_name,
                     :company_number,
                     :image_key
    end
  end
end
