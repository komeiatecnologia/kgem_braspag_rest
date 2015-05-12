module KBraspag
  module Request
    module Default
      class Customer
        include KBraspag::Helpers

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
          valid_class_type_?(:name, name, String) && present_?(name, "name")
        end
      end
    end
  end
end
