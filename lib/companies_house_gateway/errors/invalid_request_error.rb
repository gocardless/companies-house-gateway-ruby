module CompaniesHouseGateway
  class InvalidRequestError < CompaniesHouseGatewayError
    attr_accessor :param

    def initialize(message, param, status=nil, response_body=nil)
      super(message, status, response_body)
      @param = param
    end
  end
end
