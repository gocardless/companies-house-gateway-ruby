module CompaniesHouseGateway
  class Config
    DEFAULT_OPTIONS = {
      adapter:          Faraday.default_adapter,
      sender_id:        nil,
      password:         nil,
      email:            nil,
      raw:              false,
      api_endpoint:     "http://xmlgw.companieshouse.gov.uk/v1-0/xmlgw/Gateway",
      user_agent:       "CompaniesHouseGateway Ruby Gem #{CompaniesHouseGateway::VERSION}".freeze
    }.freeze

    def initialize
      @config = {}
      yield self if block_given?
    end

    def [](name)
      @config.fetch(name, DEFAULT_OPTIONS[name])
    end

    def []=(name, val)
      @config[name] = val
    end

    def clone
      Config.new { |config| @config.each { |k,v| config[k] = v } }
    end
  end
end

