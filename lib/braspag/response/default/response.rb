module KBraspag
  module Response
    module Default
      # require 'lib/braspag/pagador/pagador'
      # require 'lib/braspag/response/default/errors'

      class Response
        include KBraspag::Pagador

        attr_reader :merchant_order_id, :request_id

        def initialize(hash)
          @merchant_order_id = hash['MerchantOrderId']
          @request_id = hash['RequestId']
        end

        def success?
          @success ||= operation_success?(@payment.status)
        end

        def messages
          unless @messages
            @messages = []
            @messages << reason_message
            @messages << provider_message if exists_provider_message?
          end
          @messages
        end

        def payment_id
          @payment.payment_id
        end

        def self.build_response(response)
          body = body_parse(response.body)
          if response.kind_of? Net::HTTPSuccess
            body['RequestId'] = response['RequestId']
            build_sucess_response(body)
          else
            body = [] if body.nil?
            body << response['RequestId']
            build_error_response(body)
          end
        end

        private
        def self.body_parse(body)
          begin
            return eval(body)
          rescue Exception => e
            return JSON.parse(body)
          end
        end

        def self.build_sucess_response(response_hash)
          send(:new, response_hash)
        end

        def self.build_error_response(response_array)
          KBraspag::Response::Default::Errors.new(response_array)
        end

        def reason_message
          REASON_MESSAGE[@payment.reason_code]
        end

        def provider_message
          "#{@payment.provider_return_code} - #{@payment.provider_return_message}"
        end

        def exists_provider_message?
          @payment.respond_to?(:provider_return_code) && @payment.provider_return_code
        end
      end
    end
  end
end
