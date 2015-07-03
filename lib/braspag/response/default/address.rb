module KBraspag
  module Response
    module Default
      class Address
        attr_reader :street, :number, :complement, :zip_code, :city, :state,
                    :country

        def initialize(hash)
          @street = hash['Street']
          @number = hash['Number']
          @complement = hash['Complement']
          @zip_code = hash['ZipCode']
          @city = hash['City']
          @state = hash['State']
          @country = hash['Country']
        end
      end
    end
  end
end
