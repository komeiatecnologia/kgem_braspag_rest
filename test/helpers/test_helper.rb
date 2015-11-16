require 'helpers/helpers'
require 'lib/kgem_braspag_rest'


module TestHelper
  include KBraspag::Helpers

  def each_expected_and_returned(braspag_hash, object)
    object.instance_variables.each do |m|
      method = m.gsub('@','')
      value_expected = get_value_expected(braspag_hash, object, method)
      value_returned = object.send(method.to_sym)
      yield value_expected, value_returned
    end
  end

  private
  def get_value_expected(braspag_hash, object, method)
    return status_message(object.status) if method == 'status_message'
    braspag_hash[snakecase_to_braspagcase(method)]
  end

  def status_message(key)
    KBraspag::Pagador::STATUS[key]
  end
end
