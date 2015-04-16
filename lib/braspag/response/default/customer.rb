module KBraspag
  module Responde
    module Default
      class Customer
        attr_reader :name

        def initialize(hash)
          @name = hash['Name']
        end
      end
    end
  end
end
