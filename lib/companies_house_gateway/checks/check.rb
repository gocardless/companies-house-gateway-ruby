module CompaniesHouseGateway
  module Checks
    module Check
      def self.included(base)
        base.extend(ClassMethods)
      end

      def initialize(client)
        @client = client
      end

      def perform(data = {})
        data = self.class.default_inputs.merge(data)
        check_params(data)
        check_type = Util.underscore(Util.demodulize(self.class))
        @client.perform_check(check_type, data)
      end

      private

      def check_params(data)
        self.class.required_inputs.each do |param|
          if data[param].nil?
            msg = "#{Util.demodulize(self.class)} requires a #{param}"
            raise InvalidRequestError.new(msg, param)
          end
        end

        data.keys.each do |param|
          unless self.class.allowed_inputs.include?(param)
            msg = "#{Util.demodulize(self.class)} does not accept " +
                  "#{param}. Only the following inputs are permitted: " +
                  "#{self.class.allowed_inputs.to_a}"
            raise InvalidRequestError.new(msg, param)
          end
        end
      end

      module ClassMethods
        # Add one or more required arguments
        def required_input(*inputs)
          @required_inputs = self.required_inputs.union(inputs)
        end

        # Accessor for the check's required arguments
        def required_inputs
          @required_inputs ||= Set.new
        end

        # Add one or more default arguments
        def default_input(input)
          @default_inputs = input.merge(self.default_inputs)
        end

        # Accessor for the check's default arguments
        def default_inputs
          @default_inputs ||= {}
        end

        def allowed_inputs
          self.required_inputs.union(self.default_inputs.keys)
        end
      end
    end
  end
end