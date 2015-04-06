module Braspag
  module Model
    module Default
      require 'lib/helpers/helpers'

      class CreditCard
        include Braspag::Helpers

        attr_reader :card_number, :holder, :expiration_date, :security_code, :brand
        @@EXPIRATION_DATE_REGEX = /^\d{1,2}\/\d{4}$/.freeze
        @@VALID_CARD_NUMBER_FORMAT = /^\d{16}$/.freeze
        @@BRANDS = {
                  :visa => 'Visa', :mastercard => 'Mastercard', :amex => 'Amex',
                  :elo => 'Elo', :auria => 'Auria', :jcb => 'JCB',
                  :diners => 'Diners', :discover => 'Discover'
                 }.freeze

        def initialize
          @card_number = nil
          @holder = nil
          @expiration_date = nil
          @security_code = nil
          @brand = nil
        end

        def card_number=(number)
          raise TypeError, msg_invalid_class(number, String) if invalid_class_type?(number, String)
          raise ArgumentError, msg_can_not_be_empty("card_number") if empty?(number)
          raise ArgumentError, "Invalid card number format: #{number}, expected 1111222233334444(16 digits)" if invalid_card_number_format?(number)
          @card_number = number
        end

        def holder=(holder)
          raise ArgumentError, msg_invalid_class(holder, String) if invalid_class_type?(holder, String)
          raise ArgumentError, msg_can_not_be_empty("holder") if empty?(holder)
          @holder = holder
        end

        def expiration_date=(month_year)
          raise TypeError, msg_invalid_class(month_year, String) if invalid_class_type?(month_year, String)
          raise ArgumentError, msg_can_not_be_empty("expiration_date") if empty?(month_year)
          raise ArgumentError, "Invalid date format: #{month_year}, expected XX/XXXX" if invalid_expiration_date?(month_year)
          @expiration_date = month_year
        end

        def security_code=(security_code)
          raise TypeError, msg_invalid_class(security_code, String) if invalid_class_type?(security_code, String)
          raise ArgumentError, msg_can_not_be_empty("security_code") if empty?(security_code)
          @security_code = security_code
        end

        def brand=(brand)
          raise TypeError, msg_invalid_class(brand, Symbol) if invalid_class_type?(brand, Symbol)
          raise ArgumentError, msg_invalid_parameter(brand, @@BRANDS) if brand_not_exist?(brand)
          @brand = @@BRANDS[brand]
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
        def invalid_card_number_format?(value)
          value !~ @@VALID_CARD_NUMBER_FORMAT
        end
        def invalid_expiration_date?(month_year)
          month_year !~ @@EXPIRATION_DATE_REGEX
        end

        def brand_not_exist?(brand)
          !@@BRANDS.key? brand
        end
      end
    end
  end
end
