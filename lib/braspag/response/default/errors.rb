module KBraspag
  module Response
    module Default
      class Errors
        attr_reader :errors, :request_id

        def initialize(array)
          @errors = []
          @request_id = array.last
          array.each do |error|
            @errors << "#{error['Code']} - #{error['Message']}"
          end
        end

        def success?
          @success ||= false
        end

      end
    end
  end
end
