module KBraspag
  module Response
    module Default
      class Errors
        attr_reader :messages, :request_id

        def initialize(array)
          @messages = []
          @request_id = array.last
          array.each do |error|
            @messages << "#{error['Code']} - #{error['Message']}"
          end
        end

        def success?
          @success ||= false
        end

      end
    end
  end
end
