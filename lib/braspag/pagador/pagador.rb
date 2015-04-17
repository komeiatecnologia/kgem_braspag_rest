module KBraspag
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

    STATUS_MESSAGE = {
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
       0 => 'Sucesso',
       1 => 'Afiliação não encontrada',
       2 => 'Saldo insuficiênte',
       3 => 'Cartão de crédito não encontrado',
       4 => 'A conexão com o adquirente falhou',
       5 => 'Tipo de transação inválido',
       6 => 'Plano de pagamento inválido',
       7 => 'Negado',
       8 => 'Agendado',
       9 => 'Aguardando',
      10 => 'Autenticado',
      11 => 'Não autenticado',
      12 => 'Problemas com o cartão de crédito',
      13 => 'Cartão de crédito cancelado',
      14 => 'Cartão de crédito bloqueado',
      15 => 'Cartão de crédito expirado',
      16 => 'Abortado por suspeita de fraude',
      17 => 'Análise antifraude falhou',
      18 => 'Tente Novamente',
      19 => 'Valor inválido',
      20 => 'Problemas com a emissora',
      21 => 'Número de cartão de crédito inválido',
      22 => 'Conexão expirou',
      98 => 'Requisição inválida',
      99 => 'Erro desconhecido'
    }.freeze
  end
end
