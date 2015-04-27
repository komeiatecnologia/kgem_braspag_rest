module KBraspag
  module Response
    module Default
      require 'lib/braspag/pagador/pagador'
      require 'lib/braspag/response/default/errors'

      class Response
        include KBraspag::Pagador

        attr_reader :merchant_order_id

        def initialize(hash)
          @merchant_order_id = hash['MerchantOrderId']
        end

        def success?
          @success ||= operation_success?(@payment.status)
        end

        def errors
          @errors ||= [
                        REASON_MESSAGE[@payment.reason_code],
                        "#{@payment.provider_return_code} - #{@payment.provider_return_message}"
                      ]
        end

        def self.build_response(response)
          hash = body_to_hash(response.body)
          if response.kind_of? Net::HTTPSuccess
            build_sucess_response(hash)
          else
            build_error_response(hash)
          end
        end

        private
        def self.build_sucess_response(response_hash)
          send(:new, response_hash)
        end

        def self.build_error_response(response_array)
          KBraspag::Response::Default::Errors.new(response_array)
        end

        def self.body_to_hash(body)
          eval(body)
        end
      end
    end
  end
end
