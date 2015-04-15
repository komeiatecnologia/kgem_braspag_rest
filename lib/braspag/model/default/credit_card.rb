module Braspag
  module Model
    module Default
      require 'lib/helpers/helpers'

      class CreditCard
        include Braspag::Helpers

        attr_reader :card_number, :holder, :expiration_date, :security_code, :brand
        @@EXPIRATION_DATE_REGEX = /^\d{1,2}\/\d{4}$/.freeze
        @@VALID_CARD_NUMBER_FORMAT = /^\d{16}$/.freeze
        @@BRANDS = ['Visa', 'Mastercard', 'Amex', 'Elo', 'Auria', 'JCB', 'Diners', 'Discover'].freeze

        def initialize
          @card_number = nil
          @holder = nil
          @expiration_date = nil
          @security_code = nil
          @brand = nil
        end

        def card_number=(number)
          @card_number = number if valid_card_number?(number)
        end

        def holder=(holder)
          @holder = holder if valid_holder?(holder)
        end

        def expiration_date=(month_year)
          @expiration_date = month_year if valid_expiration_date?(month_year)
        end

        def security_code=(security_code)
          @security_code = security_code if valid_security_code?(security_code)
        end

        def brand=(brand)
          @brand = brand if valid_brand?(brand)
        end

        def self.all_brands
          @@BRANDS
        end

        def to_braspag_hash
          {
            "CardNumber" => @card_number,
            "Holder" => @holder,
            "ExpirationDate" => @expiration_date,
            "SecurityCode" => @security_code,
            "Brand" => @brand
          }
        end

        private
        def valid_brand?(brand)
          valid_class_type?(brand, String) && parameter_exists?(brand, @@BRANDS)
        end

        def valid_security_code?(security_code)
          valid_class_type?(security_code, String) && present?(security_code, "security_code")
        end

        def valid_expiration_date?(month_year)
          valid_class_type?(month_year, String) && present?(month_year, "expiration_date") && valid_expiration_date_format?(month_year)
        end

        def valid_holder?(holder)
          valid_class_type?(holder, String) && present?(holder, 'holder')
        end

        def valid_card_number?(number)
          valid_class_type?(number, String) && present?(number, "card_number") && valid_card_number_format?(number)
        end

        def valid_card_number_format?(value)
          raise ArgumentError, "Invalid card number format: #{value}, expected 1111222233334444(16 digits)", "#{self.class}" if value !~ @@VALID_CARD_NUMBER_FORMAT
          true
        end

        def valid_expiration_date_format?(month_year)
          raise ArgumentError, "Invalid date format: #{month_year}, expected XX/XXXX", "#{self.class}" if month_year !~ @@EXPIRATION_DATE_REGEX
          true
        end
      end
    end
  end
end
