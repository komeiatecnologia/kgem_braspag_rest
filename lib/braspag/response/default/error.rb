# module KBraspag
#   module Response
#     module Default
#       class Error
#         attr_reader :message, :code

#         def initialize(hash)
#           @code = hash['Code']
#           @message = hash['Message']
#         end

#       end
#     end
#   end
# end
