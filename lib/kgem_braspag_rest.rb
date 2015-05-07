require 'lib/braspag/default_configuration'
require 'lib/payment/complete_payment_slip'
require 'lib/payment/simplified_credit_card'
require 'lib/payment/cancel'

module KBraspag
  SimplifiedCreditCard = Payment::SimplifiedCreditCard
  SCC = SimplifiedCreditCard

  CompletePaymentSlip = Payment::CompletePaymentSlip
  CPS = CompletePaymentSlip

  Cancel = Payment::Cancel
  C = Cancel
end

