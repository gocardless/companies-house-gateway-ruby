require 'faraday_middleware'
require 'nokogiri'

require 'companies_house_gateway/version'
require 'companies_house_gateway/constants'
require 'companies_house_gateway/util'
require 'companies_house_gateway/config'
require 'companies_house_gateway/request'
require 'companies_house_gateway/client'

require 'companies_house_gateway/errors/companies_house_gateway_error'

require 'companies_house_gateway/checks/check'
require 'companies_house_gateway/checks/name_search'
require 'companies_house_gateway/checks/number_search'
require 'companies_house_gateway/checks/company_appointments'
require 'companies_house_gateway/checks/company_details'
require 'companies_house_gateway/checks/officer_search'
require 'companies_house_gateway/checks/officer_details'

module CompaniesHouseGateway
  def self.configure(&block)
    @config = Config.new(&block)
  end

  def self.perform_check(*args)
    client.perform_check(*args)
  end

  Constants::SUPPORTED_REQUESTS.each do |name|
    class_eval <<-EOM
      def self.#{Util.underscore(name)}(*args)
        client.send(:#{Util.underscore(name)}, *args)
      end
    EOM
  end

  # Require configuration before use
  def self.config
    if @config
      @config
    else
      msg = "No config found. Use CompaniesHouseGateway.configure to set "
            "username and password. See " +
            "https://github.com/gocardless/companies-house-gateway " +
            "for details."
      raise CompaniesHouseGatewayError.new(msg)
    end
  end

  def self.client
    @client ||= Client.new(config)
  end
  private_class_method :client
end

