module KBraspag
  module Response
    module Default
      class Link
        attr_reader :method, :rel, :h_ref

        def initialize(h)
          @method = h[:method]
             @rel = h[:rel]
           @h_ref = h[:h_ref]
        end

        def self.build_array(array)
          ary = []
          array.each do |link|
            ary << Link.new(link)
          end
          ary
        end
      end
    end
  end
end
