module KBraspag
  module Error
    module Pagador

      def operation_success?(status)
        status == 1 || status == 2
      end

      STATUS = {
         0 => 'Not Finished',
         1 => 'Authorized',
         2 => 'Payment Confirmed',
         3 => 'Denied',
        10 => 'Voided',
        11 => 'Refunded',
        12 => 'Pending',
        13 => 'Aborted'
      }.freeze

      SSTATUS_MESSAGE = {
         0 => 'Não finalizada',
         1 => 'Autorizada',
         2 => 'Pagamento confirmado',
         3 => 'Negado',
        10 => 'Anulado',
        11 => 'Reembolsado',
        12 => 'Pendente',
        13 => 'Abortado'
      }.freeze

      REASON_MESSAGE = {
                          'Successful' => 'Sucesso',
                 'AffiliationNotFound' => 'Afiliação não encontrada',
                   'InsufficientFunds' => 'Saldo insuficiênte',
               'CouldNotGetCreditCard' => 'Cartão de crédito não encontrado',
        'ConnectionWithAcquirerFailed' => 'A conexão com o adquirente falhou',
              'InvalidTransactionType' => 'Tipo de transação inválido',
                  'InvalidPaymentPlan' => 'Plano de pagamento inválido',
                              'Denied' => 'Negado',
                           'Scheduled' => 'Agendado',
                             'Waiting' => 'Aguardando',
                       'Authenticated' => 'Autenticado',
                    'NotAuthenticated' => 'Não autenticado',
              'ProblemsWithCreditCard' => 'Problemas com o cartão de crédito',
                        'CardCanceled' => 'Cartão de crédito cancelado',
                   'BlockedCreditCard' => 'Cartão de crédito bloqueado',
                         'CardExpired' => 'Cartão de crédito expirado',
                      'AbortedByFraud' => 'Abortado por suspeita de fraude',
                   'CouldNotAntifraud' => 'Análise antifraude falhou',
                            'TryAgain' => 'Tente Novamente',
                       'InvalidAmount' => 'Valor inválido',
                  'ProblemsWithIssuer' => 'Problemas com a emissora',
                   'InvalidCardNumber' => 'Número de cartão de crédito inválido',
                             'TimeOut' => 'Conexão expirou',
                      'InvalidRequest' => 'Requisição inválida',
                       'InternalError' => 'Erro desconhecido'
      }.freeze
    end
  end
end
