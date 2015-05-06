module KBraspag
  module Response
    require 'lib/braspag/response/default/link'
    require 'lib/braspag/pagador/pagador'
    require 'lib/braspag/response/default/errors'

    class Cancel
      include KBraspag::Pagador
      attr_reader :request_id, :status, :reason_code, :reason_message, :provider_return_code, :provider_return_message, :links

      def initialize(hash)
        @request_id = hash['RequestId']
        @status = hash['Status']
        @reason_code = hash["ReasonCode"]
        @reason_message = hash["ReasonMessage"]
        @provider_return_code = hash["ProviderReturnCode"]
        @provider_return_message = hash["ProviderReturnMessage"]
        @links = Default::Link.build_array(hash["Links"])
      end

      def self.build_response(response)
        body = eval(response.body)
        if response.kind_of? Net::HTTPSuccess
          body['RequestId'] = response['RequestId']
          build_sucess_response(body)
        else
          body = [] if body.nil?
          body << response['RequestId']
          build_error_response(body)
        end
      end

      def success?
        @success ||= operation_success?(@status)
      end

      def messages
        @messages ||= build_messages
      end

      private
      def build_messages
        @messages = []
        @messages << REASON_MESSAGE[@reason_code]
        @messages << "#{@provider_return_code} - #{@provider_return_message}" if @provider_return_code
      end

      def self.build_sucess_response(response_hash)
        send(:new, response_hash)
      end

      def self.build_error_response(response_array)
        KBraspag::Response::Default::Errors.new(response_array)
      end
    end
  end
end
