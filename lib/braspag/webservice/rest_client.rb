module KBraspag
  module WebService
    class RestClient
      # encoding: UTF-8
      require 'net/http'
      require 'net/https'
      require 'openssl'
      require 'klog'
      require 'securerandom'
      require 'json'

      # extend KBraspag::Configuration
      @@REGEX_UUID = /^(.{8})(.{4})(.{4})(.{4})(.{12}).*/.freeze
      @@DEFAULT_METHODS = { :get => Net::HTTP::Get, :post => Net::HTTP::Post,
                            :put => Net::HTTP::Put, :delete => Net::HTTP::Delete
                          }

      # define_setting :TIMEOUT, 5
      # define_setting :PAYMENT_URL, URI("https://apisandbox.braspag.com.br")
      # define_setting :QUERY_URL, URI("https://apiquerysandbox.braspag.com.br")
      # define_setting :MERCHANT_ID, "ba5908fb-87d1-4011-a158-02bec105aa15"
      # define_setting :MERCHANT_KEY, "GRGYVAUUNUWGIGSQKTNKNCFDKQVVGBYBDERAFHOG"
      # define_setting :REQUEST_ID, "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
      # define_setting :CONNECTION_ATTEMPTS, 3

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
       @http ||= new_http
      end

      def build_request(method, resource, params = nil)
        uri = URI(resource)
        @req = new_request(method, uri)
        @req.body = params.to_json if params
        logger.log_request(@req, "#{@@PAYMENT_URL}#{uri.path}")
      end

      def send_request
        response = nil
        @@CONNECTION_ATTEMPTS.times do |i|
          response = https.request(@req)
          logger.log_response(response)
          break unless response.nil?
        end
        response
      end

      def new_request(method, uri)
        @@DEFAULT_METHODS[method].new(uri.path, build_header)
      end

      def new_http
        @http = Net::HTTP.new(@@PAYMENT_URL.host, @@PAYMENT_URL.port)
        @http.use_ssl = true
        @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        @http.read_timeout = @@TIMEOUT
        @http
      end

      def build_header
        @HEADER ||= {"Content-Type" => "application/json",
                     "Accept" => "application/json",
                     "MerchantId" => KBraspag.merchant_id,
                     "MerchantKey" => KBraspag.merchant_key,
                     "RequestId" => generate_uuid
                    }
      end

      def generate_uuid
        uuid = SecureRandom.hex(16)
        "#{$1}-#{$2}-#{$3}-#{$4}-#{$5}" if uuid =~ @@REGEX_UUID
      end

      def logger
        KLog::Log.new
      end
    end
  end
end
