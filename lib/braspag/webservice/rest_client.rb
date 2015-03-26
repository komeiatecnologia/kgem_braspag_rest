module Braspag
  module WebService
    class RestClient
      require 'net/http'
      require 'net/https'
      require 'openssl'
      require 'klog'

      @@DEFAULT_METHODS = { :get => Net::HTTP::Get, :post => Net::HTTP::Post,
                            :put => Net::HTTP::Put, :delete => Net::HTTP::Delete
                          }
      @@TIMEOUT = 10
      @@URL = URI("https://www.google.com.br")
      @@DEFAULT_HEADER = {"Content-Type" => "application/json",
                                "Accept" => "application/json",
                            "MerchantId" => "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                           "MerchantKey" => "0123456789012345678901234567890123456789",
                             "RequestId" => "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
                          }

      def initialize
        @req = nil
      end

      def get(resource)
        build_request(:get, resource)
        self
      end

      def post(resource, params)
        build_request(:post, resource, params)
        self
      end

      def put(resource, params)
        build_request(:put, resource, params)
        self
      end

      def patch(resource, params)
        build_request(:patch, resource, params)
        self
      end

      def delete(resource)
        build_request(:delete, resource)
        self
      end

      def request
        send_request
      end

      private
      def https
        if @http.nil?
          @http = Net::HTTP.new(@@URL.host, @@URL.port)
          @http.use_ssl = true
          @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          @http.read_timeout = @@TIMEOUT
          @http
        else
          @http
        end
      end

      def build_request(method, resource, params = nil)
        uri = URI(resource)
        @req = @@DEFAULT_METHODS[method].new(uri.path, @@DEFAULT_HEADER)
        @req.body = params.to_json if params
        logger.log_request(@req, "#{@@URL}#{uri.path}")
      end

      def send_request
        res = https.request(@req)
        logger.log_response(res)
        res
      end

      def logger
        KLog::Log.new
      end
    end
  end
end
