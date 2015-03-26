module Braspag
  module WebService
    TIMEOUT = 10
    URL = URI("https://apisandbox.braspag.com.br")
    DEFAULT_HEADER = {"Content-Type" => "application/json",
                            "Accept" => "application/json",
                        "MerchantId" => "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
                       "MerchantKey" => "0123456789012345678901234567890123456789",
                         "RequestId" => "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
                      }
    class RestClient
      require 'net/http'
      require 'uri'

      @@DEFAULT_METHODS = { :get => Net::HTTP::Get, :post => Net::HTTP::Post,
                            :put => Net::HTTP::Put, :patch => Net::HTTP::Patch,
                            :delete => Net::HTTP::Delete
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
          @http = Net::HTTP.new(URL.host, URL.port)
          @http.use_ssl = true
          @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
          @http.read_timeout = TIMEOUT
          @http
        else
          @http
        end
      end

      def build_request(method, resource, params = nil)
        uri = URI.parse(resource)
        @req = @@DEFAULT_METHODS[method].new(uri, DEFAULT_HEADER)
        @req.body = params.to_json if params
        logger.log_request(@req, "#{URL}/#{uri}")
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
