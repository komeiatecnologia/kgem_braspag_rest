module KBraspag
  module Response
    module Default
      class Customer
        attr_reader :name, :identification

        def initialize(hash)
          @name = hash['Name']
          @identification = hash['Identification']
        end
      end
    end
  end
end
