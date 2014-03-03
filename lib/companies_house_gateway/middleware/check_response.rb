module CompaniesHouseGateway
  module Middleware
    class CheckResponse < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |env|
          check_for_errors(env)
          response_values(env)
        end
      end

      def response_values(env)
        { status: env[:status], headers: env[:headers], body: env[:body] }
      end

      def check_for_errors(env)
        body = env[:body]["GovTalkMessage"]
        unless body && body["GovTalkDetails"]
          raise InvalidResponseError.new(env[:body], env[:status], env)
        end

        if body["GovTalkDetails"]["GovTalkErrors"]
          error = body["GovTalkDetails"]["GovTalkErrors"].values.flatten.first
          raise APIError.new(error['Text'], error['Number'], env[:status], env)
        end
      end
    end

    Faraday.register_middleware :response, check_ch_response: CheckResponse
  end
end