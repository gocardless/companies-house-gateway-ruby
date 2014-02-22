module CompaniesHouseGateway
  class Client
    def initialize(config=nil)
      @config = (config || CompaniesHouseGateway.config).clone
    end

    def perform_check(*args)
      request = Request.new(connection, @config)
      request.perform(*args)
    end

    def name_search(*args)
      check = Checks::NameSearch.new(self)
      check.perform(*args)
    end

    def number_search(*args)
      check = Checks::NumberSearch.new(self)
      check.perform(*args)
    end

    def company_appointments(*args)
      check = Checks::CompanyAppointments.new(self)
      check.perform(*args)
    end

    def config
      @config
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

      Faraday.new(options) do |conn|
        conn.response :xml  unless @config[:raw]            # Parse response
        conn.response :follow_redirects, limit: 3           # Follow redirect
        conn.response :raise_error                          # Raise errors
        conn.adapter @config[:adapter]
      end
    end
  end
end
