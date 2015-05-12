require 'helpers/helpers'

module TestHelper
  include KBraspag::Helpers

  def each_expected_and_returned(braspag_hash, object)
    object.instance_variables.each do |m|
      method = m.gsub('@','')
      value_expected = braspag_hash[snakecase_to_braspagcase(method)]
      value_returned = object.send(method.to_sym)
      yield value_expected, value_returned
    end
  end
end
