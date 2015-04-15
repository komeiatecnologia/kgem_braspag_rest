module Braspag
  module Helpers
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
