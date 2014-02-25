module CompaniesHouseGateway
  module Checks
    class Document
      include Check

      required_input :doc_request_key,
                     :user_reference

      default_input user_reference: "REFERENCE"
    end
  end
end
