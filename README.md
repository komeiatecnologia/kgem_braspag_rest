Documentação API Pagador Rest: <http://apidocs.braspag.com.br>

COMO USAR
=========

1 - Instale a gem kgem_braspag_rest

2 - Informar o MerchantID e MerchantKey
  Em projetos Rails basta criar um arquivo .rb no diretório config/initializers e seguir o exemplo abaixo:

    require 'kgem_braspag_rest'

    KBraspag.configuration do |config|

      config.merchant_id = "MeuMerchantID"

      config.merchant_key = "MeuMerchantKey"

    end

### ALTERAR AS CONFIGURAÇÕES DEFAULT

###### Exemplos:

1 - Desejo alterar o timeout de 15 para 5 segundos.

    KBraspag.configuration { |config| config.timeout = 5 }

2 - Desejo incluir mais um gerador de boleto

    KBraspag.configuration { |config| config.payment_slip_providers[:santander] = "Santander" }

3 - Desejo substituir todas operadoras de cartões

    kBraspag.configuration do |config|

      config.credit_card_providers = {

        :operadora1 => 'Operadora 1',

        :operadora2 => 'Operadora 2'

      }

    end


## Abaixo todas as configurações disponíveis e os valores default:

      KBraspag.configuration do |config|

        # FILE PATH TO CA CERTIFICATE (*.pem)
        config.ca_file_path = "./braspag.pem"

        # PAYMENT METHODS AVAILABLE
        config.payment_types = {

          :credit_card => "CreditCard",

          :debit_card => "DebitCard",

          :payment_slip => "Boleto"

        }

        # AVAILABLE OPTIONS FOR RESPONSIBLE FOR INSTALLMENT SALES MADE BY CREDIT CARD
        config.responsible_for_installment = {

          :merchant => "ByMerchant",

          :issuer => "ByIssuer"

        }

        # CREDIT CARD BRANDS AVAILABLE
        config.credit_card_brands = {

          :visa => 'Visa',

          :mastercard => 'Master',

          :amex => 'Amex',

          :elo => 'Elo',

          :aura => 'Aura',

          :jcb => 'JCB',

          :diners => 'Diners',

          :discover => 'Discover',

          :hipercard => 'Hipercard',

          :hiper => 'Hiper'

        }

        # AVAILABLE CREDI CARD PROVIDERS LIST
        config.credit_card_providers = {

          :simulado => "Simulado",

          :cielo => "Cielo",

          :rede => "Redecard"

        }

        # DEBIT CARD PROVIDERS AVAILABLE
        define_setting :debit_card_providers, {

          :simulado => "Simulado",

          :cielo => "Cielo"

        }

        # AVAILABLE PAYMENT SLIP PROVIDERS LIST
        config.payment_slip_providers = {

          :bradesco => "Bradesco",

          :banco_do_brasil => "BancoDoBrasil",

          :citibank => "CitiBank",

          :itau => "Itau",

          :brb => "Brb",

          :caixa => "Caixa",

          :santander => "Santander",

          :hsbc => "HSBC",

          :simulado => "Simulado"

        }

        #REQUEST SETTINGS
        config.timeout = 20

        config.merchant_id = nil

        config.merchant_key = nil

        config.connection_attempts = 3

        #URLs
        define_setting :payment_url = "https://api.braspag.com.br"

        define_setting :query_url = "https://apiquery.braspag.com.br"

        #RESOURCES
        config.complete_payment_slip_resource = "/v2/sales/"

        config.simplified_credit_card_resource = "/v2/sales/"

        config.cancel_resource = "/v2/sales/"

        # DEFAULT RESPONSIBLE INSTALLMENTS(:issuer|:merchant)
        config.interest = :issuer

    end

# REALIZAR PAGAMENTOS


## Exemplo Boleto

    boleto = KBraspag::CompletePaymentSlip.new # Ou use o alias KBraspag::CPS.new
    boleto.customer.name = "José da Silva"
    boleto.customer.identity_type = 'CPF' # CPF|CNPJ
    boleto.customer.identity = "1234567890"
    boleto.customer.email = "email@email.com"
    boleto.customer.birthdate = "1999-10-10" # YYYY-MM-DD

    boleto.customer.address.street = "Minha Rua"
    boleto.customer.address.number = "1234"
    boleto.customer.address.complement = "Meu Complemento"
    boleto.customer.address.zip_code = "86010-540"
    boleto.customer.address.city = "Minha Cidade"
    boleto.customer.address.state = "PR" #Deve ser a sigla
    boleto.customer.address.country = "BRA" #Opcional o default já é Brasil

    boleto.customer.delivery_address.street = "Minha Rua"
    boleto.customer.delivery_address.number = "1234"
    boleto.customer.delivery_address.complement = "Meu Complemento"
    boleto.customer.delivery_address.zip_code = "86010-540"
    boleto.customer.delivery_address.city = "Minha Cidade"
    boleto.customer.delivery_address.state = "PR" #Deve ser a sigla/uf
    boleto.customer.delivery_address.country = "BRA" #Opcional o default já é Brasil

    boleto.merchant_order_id = '2014111703'
    boleto.payment.amount = 15700 #Ou 15.700, "15,700"
    boleto.payment.provider = :meu_banco
    boleto.payment.address = "Rua Teste"
    boleto.payment.payment_slip_number = "123"
    boleto.payment.assignor = "Empresa Teste"
    boleto.payment.demonstrative = "Desmonstrative Teste"
    boleto.payment.expiration_date = "2020-05-1"
    boleto.payment.instructions = "Aceitar somente até a data de vencimento, após essa data juros de 1% dia."

    # Tentar realizar o pagamento
    resposta = boleto.pay

    #Verificar se a transação foi criada com sucesso (true|false)
    resposta.transaction_created?

    #Verificar se a transação foi realizada com sucesso (true|false)
    resposta.success?

    #Verificar se a transação teve o pagamento confirmado (true| false)
    resposta.paid?

    #Verificar se a transação foi cancelada/estornada (true|false)
    resposta.canceled?

    #Verificar todas as mensagens retornadas pelo gateway (Array)
    resposta.messages

    #Verificar a messagem retornada de maior relevancia (String)
    resposta.messages.first

## Exemplo Cartão de Crédito

    cartao = KBraspag::SimplifiedCreditCard.new # Ou KBraspag::SCC.new
    cartao.merchant_order_id = '2014111703'
    cartao.payment.capture = true # default já é true, portanto pode ser omitida a atribuição
    cartao.payment.amount = 15700
    cartao.payment.provider = :minha_operadora
    cartao.payment.installments = 1
    cartao.customer.name = "José da Silva"
    cartao.credit_card.card_number = "0000000000000006"
    cartao.credit_card.holder = "J Silva"
    cartao.credit_card.expiration_date = "12/2021"
    cartao.credit_card.security_code = "123"
    cartao.credit_card.brand = :minha_bandeira

    # Tentar realizar o pagamento
    resposta = cartao.pay

    #Verificar se a transação foi criada com sucesso (true|false)
    resposta.transaction_created?

    #Verificar se a transação foi realizada com sucesso (true|false)
    resposta.success?

    #Verificar se a transação teve o pagamento confirmado (true| false)
    resposta.paid?

    #Verificar se a transação foi cancelada/estornada (true|false)
    resposta.canceled?

    #Verificar todas as mensagens retornadas pelo gateway (Array)
    resposta.messages

    #Verificar a messagem retornada de maior relevancia (String)
    resposta.messages.first

## Exemplo Cartão de Débito

    sdc = KBraspag::SDC.new # OU KBraspag::SimplifiedDebitCard.new

    sdc.merchant_order_id = "11111111"

    sdc.customer.name = "Komeia Interativa"
    sdc.customer.identity = "11122233344"
    sdc.customer.identity_type = "CNPJ" # OU "CPF"
    sdc.customer.email = "email@komeia.com"
    sdc.customer.birthdate = "1999-08-14"

    sdc.customer.address.street = "Av JK"
    sdc.customer.address.number = "1086"
    sdc.customer.address.complement = "Centro"
    sdc.customer.address.zip_code = "86010-540"
    sdc.customer.address.city = "Londrina"
    sdc.customer.address.state = "PR"

    sdc.payment.amount = 100
    sdc.payment.provider = :cielo
    sdc.payment.return_url = "https://komeia.com"

    sdc.payment.debit_card.card_number = "0000000000000000"
    sdc.payment.debit_card.holder = "Teste Komeia"
    sdc.payment.debit_card.expiration_date = "03/2050"
    sdc.payment.debit_card.security_code = "123"
    sdc.payment.debit_card.brand = :visa

    # Tentar realizar o pagamento
    resposta = sdc.pay

    #Verificar se a transação foi criada com sucesso (true|false)
    resposta.transaction_created?

    #Verificar se a transação foi realizada com sucesso (true|false)
    resposta.success?

    #Verificar se a transação teve o pagamento confirmado (true| false)
    resposta.paid?

    #Verificar se a transação foi cancelada/estornada (true|false)
    resposta.canceled?

    #Verificar todas as mensagens retornadas pelo gateway (Array)
    resposta.messages

    #Verificar a messagem retornada de maior relevancia (String)
    resposta.messages.first

# CONSULTAR PAGAMENTO/TRANSAÇÃO

## Exemplo consultar transação método 1

    consultar = KBraspag::Query.new # Ou KBraspag::Q.new

    consultar.payment_id = "uuid da transação"

    resposta = consultar.consult

## Exemplo consultar transação método 2

    consultar = KBraspag::Query.new # Ou KBraspag::Q.new

    resposta = consultar.consult("uuid da transação")

    #Verificar se a operação foi realizada com sucesso (true|false)
    resposta.success?

    #Verificar todas as mensagens retornadas pelo gateway (Array)
    resposta.messages

    #Verificar a messagem retornada de maior relevancia (String)
    resposta.messages.first

# CANCELAR PAGAMENTO/TRANSAÇÃO (Quando utilizado Redecard não use essa funcionalidade)

## Exemplo cancelar transação método 1

    cancelar = KBraspag::Cancel.new # Ou KBraspag::C.new

    cancelar.payment_id = "uuid da transação"

    # Caso não seja informado o valor é estornado todo o valor da transação
    cancelar.amount = 10 # Ou 10.00, "10,00"

    # Tentar cancelar/estornar
    resposta = cancelar.cancel

## Exemplo cancelar transação método 2

    cancelar = KBraspag::Cancel.new # Ou KBraspag::C.new

    # Tentar cancelar/estornar
    resposta = cancelar.cancel(payment_id, amount) #Amount é opcional

    #Verificar se a operação foi realizada com sucesso (true|false)
    resposta.success?

    #Verificar todas as mensagens retornadas pelo gateway (Array)
    resposta.messages

    #Verificar a messagem retornada de maior relevancia (String)
    resposta.messages.first
