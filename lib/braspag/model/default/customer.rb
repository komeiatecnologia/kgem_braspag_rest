module Braspag
  module Model
    class DefaultCustomer
      include Braspag::Helpers

      attr_reader :name

      def initialize
        @name = nil
      end

      def name=(name)
        raise TypeError, msg_invalid_class(name, String) if invalid_class_type?(name, String)
        raise ArgumentError, msg_can_not_be_empty("name") if empty? name
        @name = name
      end

      def to_braspag_hash
        {
          "Name" => @name
        }
      end
    end
  end
end
