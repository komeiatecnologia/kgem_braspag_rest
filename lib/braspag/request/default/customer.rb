module KBraspag
  module Request
    module Default
      class Customer
        include KBraspag::Helpers
        extend KBraspag::HelpersClass

        can_be_nil :identification

        attr_reader :name, :identification

        VALID_IDENTIFICATION = /^\d{1,11}$/

        def initialize
          @name = nil
          @identification = nil #CPF ou RG sem pontos e traços
        end

        def name=(name)
          @name = name if valid_name?(name)
        end

        def identification=(identification)
          @identification = identification if valid_identification?(identification)
        end

        def to_braspag_hash
          {
            "Name" => @name,
            'Identification' => @identification
          }
        end

        private
        def valid_name?(name)
          valid_class_type_?(:name, name, String) && present_?(name, "name")
        end

        def valid_identification?(identification)
          valid_class_type_?(:identification, identification, String)
          present_?(identification, "identification")
          valid_identification_format?(identification)
        end

        def valid_identification_format?(identification)
          raise(
                ArgumentError,
                "Invalid identification, expected string with max 11 numeric characters(CPF/CPNJ)"
                ) if identification !~VALID_IDENTIFICATION
          true
        end
      end
    end
  end
end
