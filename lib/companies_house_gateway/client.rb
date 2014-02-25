module CompaniesHouseGateway
  class Client
    def initialize(config=nil)
      @config = (config || CompaniesHouseGateway.config).clone
    end

    def perform_check(*args)
      request = Request.new(connection, @config)
      request.perform(*args)
    end

    def config
      @config
    end

    Constants::SUPPORTED_REQUESTS.each do |name|
      class_eval <<-EOM
        def #{Util.underscore(name)}(*args)
          check = CompaniesHouseGateway::Checks.const_get(:#{name}).new(self)
          check.perform(*args)
        end
      EOM
    end

    private

    def connection
      options = {
        ssl: { verify: false },
        url: @config[:api_endpoint],
        headers: {
          'Accept' => "application/xml",
          'User-Agent' => @config[:user_agent]
        }
      }

      Faraday.new(options) do |c|
        c.response :check_ch_response unless @config[:raw]  # Check XML
        c.response :xml  unless @config[:raw]               # Parse response
        c.response :follow_redirects, limit: 3              # Follow redirect
        c.response :raise_error                             # Raise errors
        c.adapter @config[:adapter]
      end
    end
  end
end
