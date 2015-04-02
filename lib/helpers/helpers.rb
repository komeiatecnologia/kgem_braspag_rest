module Braspag
  module Helpers
    def invalid_class_type?(value, klass)
      !value.kind_of? klass
    end

    def msg_invalid_class(value, klass)
      "#{value.class}: Invalid class type, expected #{klass}.class"
    end

    def msg_invalid_parameter(parameter, options)
      "Not exists #{parameter} in: #{hash_to_sentence(options)}"
    end

    def hash_to_sentence(hash)
      sentence = nil
      hash.each do |key, value|
        sentence.nil? ? sentence = "{:#{key} => '#{value}'" : sentence << ", :#{key} => '#{value}'}"
      end
      sentence
    end

    def msg_less_or_equal_zero(value)
      "Value must be greater than zero: #{value}"
    end

    def msg_can_not_be_empty(attribute)
      "#{attribute}: can't be empty"
    end

    def empty?(value)
      value.strip.empty?
    end
  end
end
