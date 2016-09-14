dragon_pay_config = Rails.application.config_for(:dragon_pay).with_indifferent_access

::DRAGON_PAY_GATEWAY = DragonPay.new dragon_pay_config

::DRAGON_PAY_TRANSACTION_REGISTRATION_URL = dragon_pay_config[:registration_url]
