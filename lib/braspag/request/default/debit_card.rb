module KBraspag
  module Request
    module Default
      class DebitCard < Card

        def brand=(brand)
          @brand = KBraspag.debit_card_brands[brand] if valid_brand?(brand)
        end

        private
        def valid_brand?(brand)
          valid_class_type_?(:brand, brand, Symbol) && parameter_exists_?(brand, KBraspag.debit_card_brands)
        end
      end
    end
  end
end
