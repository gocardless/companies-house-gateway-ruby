module CompaniesHouseGateway
  module Checks
    class Document
      include Check

      required_input :doc_request_key

      default_input user_reference: "REFERENCE"

      # Override response_body to include file URL details
      def response_body(response)
        body = response["GovTalkMessage"]["Body"]["Document"]
        body["URL"] = response.fetch("GovTalkMessage").
                               fetch("Header").
                               fetch("MessageDetails").
                               fetch("ResponseEndPoint").
                               fetch("__content__")
        body
      end
    end
  end
end
