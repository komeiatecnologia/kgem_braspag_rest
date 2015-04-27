module KBraspag
  module Response
    module Default
      # require 'lib/braspag/response/default/error'
      class Errors
        attr_reader :errors

        def initialize(array)
          @errors = []
          array.each do |error|
            @errors << "#{error['Code']} - #{error['Message']}"
          end
          @errors
        end

        def success?
          @success ||= false
        end

      end
    end
  end
end
