module KBraspag
  module Helpers
    require 'date'

    LAST_DECIMAL_PLACE = /^.*\d+[\,|\.]\d{1}$/.freeze

    def valid_class_type?(value, expected_class)
      raise TypeError, msg_invalid_class(value, expected_class), "#{self.class}" if !value.kind_of? expected_class
      true
    end

    def parameter_exists?(parameter, options)
      if options.kind_of? Array
        element_exists_in_array?(parameter, options)
      else
        element_exists_in_hash?(parameter, options)
      end
    end

    def array_to_sentece(array)
      sentence = nil
      array.each do |e|
        sentence.nil? ? sentence = "#{e}" : sentence << ", #{e}"
      end
      sentence
    end

    def hash_to_sentence(hash)
      sentence = nil
      hash.each do |key, value|
        sentence.nil? ? sentence = "{:#{key} => '#{value}'" : sentence << ", :#{key} => '#{value}'}"
      end
      sentence
    end

    def greater_than_zero?(number)
      raise ArgumentError, msg_less_or_equal_zero(number), "#{self.class}" if number <= 0
      true
    end

    def msg_less_or_equal_zero(value)
      "Value must be greater than zero: #{value}"
    end

    def present?(value, attribute)
      raise ArgumentError, msg_can_not_be_empty(attribute), "#{self.class}" if value.strip.empty?
      true
    end

    def valid?
      instance_variables.each do |at|
        at.gsub!('@','')
        raise ArgumentError, "#{msg_can_not_be_empty(at)}", "#{self.class}" if send(at).nil?
      end
      true
    end

    def msg_invalid_class(value, expected_class)
      "#{value.class}: Invalid class type, expected #{expected_class}.class"
    end

    def msg_can_not_be_empty(attribute)
      "#{attribute}: can't be empty"
    end

    def camelcase_to_snakecase(string)
      while !(string !~ /([a-z])([A-Z])/)
        string = string.gsub("#{$1}#{$2}", "#{$1}_#{$2}")
      end
      string.downcase
    end

    def snakecase_to_camelcase(string)
      while !(string !~ /([a-z])(_)([a-z])/)
        string = string.gsub("#{$1}#{$2}#{$3}", "#{$1}" + "#{$3}".upcase)
      end
      string
    end

    def snakecase_to_braspagcase(string)
      snakecase_to_camelcase(string.capitalize)
    end

    def greater_than_current_date?(day_month_year, format="%d/%m/%Y")
      raise ArgumentError, "#{day_month_year}: invalid format date, expected xx/xx/xxxx", "#{self.class}" if day_month_year !~ /(\d{1,2})\/(\d{1,2})\/(\d{4})/
      current = Time.now
      raise ArgumentError, "The date is less than current date" if Date.strptime("#{current.day}/#{current.month}/#{current.year}", format) > Date.strptime(day_month_year, format)
      true
    end

    def valid_string_size?(value, attribute, size)
      raise ArgumentError, "#{attribute} longer than #{size} characters", "#{self.class}" if value.size > size
      true
    end

    # Money manipulation
    def standardize_amount(value)
      value = string_to_integer(value) if value.kind_of? String
      value = bigdecimal_to_integer(value) if value.kind_of? BigDecimal
      value = float_to_integer(value) if value.kind_of? Float
      value
    end

    def string_to_integer(value)
      value = insert_last_decimal_place(value)
      value.gsub(/\D/, '').to_i
    end

    def bigdecimal_to_integer(value)
      value = value.to_digits
      string_to_integer(value)
    end

    def float_to_integer(value)
      value = value.to_s
      string_to_integer(value)
    end

    def insert_last_decimal_place(value)
      value << '0' unless value !~ LAST_DECIMAL_PLACE
      value
    end

  private
    def element_exists_in_hash?(key, hash)
      raise ArgumentError, "Not exists #{key} in: #{hash_to_sentence(hash)}" unless hash.key? key
      true
    end

    def element_exists_in_array?(element, array)
      raise ArgumentError, "Not exists #{element} in: #{array_to_sentece(array)}" unless array.include? element
      true
    end
  end
end
