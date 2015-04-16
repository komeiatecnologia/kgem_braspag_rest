module KBraspag
  module Response
    module Default
      require 'lib/helpers/meta'

      class Payment
        include KBraspag::Meta
        attr_reader :type, :amount, :country, :currency, :provider, :status, :extra_data_collection

        def initialize(hash)
          @type = hash['Type']
          @amount = hash['Amount']
          @country = hash['Country']
          @currency = hash['Currency']
          @provider = hash['Provider']
          @status = hash['Status']
          @extra_data_collection = hash['ExtraDataCollection']
        end

      end
    end
  end
end
