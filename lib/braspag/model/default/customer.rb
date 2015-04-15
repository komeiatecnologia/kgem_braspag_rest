module Braspag
  module Model
    module Default
      require 'lib/helpers/helpers'
      class Customer
        include Braspag::Helpers

        attr_reader :name

        def initialize
          @name = nil
        end

        def name=(name)
          @name = name if valid_name?(name)
        end

        def to_braspag_hash
          {
            "Name" => @name
          }
        end

        private
        def valid_name?(name)
          valid_class_type?(name, String) && present?(name, "name")
        end
      end
    end
  end
end
