module CompaniesHouseGateway
  class APIError < CompaniesHouseGatewayError
    attr_accessor :error_code

    def initialize(message=nil, error_code=nil, status=nil, response_body=nil)
      super(message, status, response_body)
      @error_code = error_code
    end

    def to_s
      str = super
      str += " [Error code: #{error_code}]" if error_code
      str
    end
  end
end
