module CompaniesHouseGateway
  module Middleware
    class CheckResponse < Faraday::Middleware
      def call(env)
        @app.call(env).on_complete do |env|
          response_body = env[:body]["GovTalkMessage"]

          unless response_body && response_body["GovTalkDetails"]
            raise InvalidResponseError.new(nil, env[:status], env)
          end

          if errors = response_body["GovTalkDetails"]["GovTalkErrors"]
            errors = errors.values.flatten
            messages = errors.map { |e| "(#{e['Number']}) #{e['Text']}" }
            raise APIError.new(messages.join(" | "), env[:status], env)
          end

          response_values(env)
        end
      end

      def response_values(env)
        { status: env[:status], headers: env[:headers], body: env[:body] }
      end
    end

    Faraday.register_middleware :response, check_response: CheckResponse
  end
end