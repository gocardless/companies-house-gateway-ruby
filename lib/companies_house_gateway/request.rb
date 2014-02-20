module CompaniesHouseGateway
  class Request
    def initialize(connection, config)
      @connection = connection
      @config = config
    end

    # Perform a credit check
    def perform(check_data = {})
      response = @connection.get do |request|
        request.path = @config[:api_endpoint]
        request.body = build_request_xml(check_data).to_s
      end
      @config[:raw] ? response : response.body
    rescue Faraday::Error::ClientError => e
      raise CompaniesHouseGatewayError.new(e.response[:body],
                                           e.response[:status],
                                           e.response)
    end

    # Compile the complete XML request to send to Companies House
    def build_request_xml(check_data={})
      # Not implemented
    end
  end
end
