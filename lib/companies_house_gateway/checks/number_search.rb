module CompaniesHouseGateway
  module Checks
    class NumberSearch
      REQUIRED_INPUTS = [:partial_company_number, :data_set]
      DEFAULT_INPUTS = {
        data_set: "LIVE",
        search_rows: 20,
      }
      ALLOWED_INPUTS = (DEFAULT_INPUTS.keys + REQUIRED_INPUTS).uniq

      def initialize(client)
        @client = client
      end

      def perform(data = {})
        data = DEFAULT_INPUTS.merge(data)
        check_params(data)
        check_type = Util.underscore(Util.demodulize(self.class))
        @client.perform_check(check_type, data)
      end

      private

      def check_params(data)
        REQUIRED_INPUTS.each do |param|
          if data[param].nil?
            msg = "#{Util.demodulize(self.class)} requires a #{param}"
            raise CompaniesHouseGatewayError.new(msg)
          end
        end

        data.keys.each do |param|
          unless ALLOWED_INPUTS.include?(param)
            msg = "#{Util.demodulize(self.class)} does not accept #{param}. " +
                  "Only the following inputs are permitted: #{ALLOWED_INPUTS}"
            raise CompaniesHouseGatewayError.new(msg)
          end
        end
      end
    end
  end
end
