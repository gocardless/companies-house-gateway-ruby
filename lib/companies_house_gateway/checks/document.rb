module CompaniesHouseGateway
  module Checks
    class Document
      include Check

      required_input :doc_request_key,
                     :user_reference
    end
  end
end
