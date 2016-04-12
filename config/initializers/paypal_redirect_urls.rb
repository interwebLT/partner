config = Rails.application.config_for(:paypal_redirect_urls).with_indifferent_access

Rails.configuration.paypal_return_url = config[:paypal_return_url]
Rails.configuration.paypal_cancel_url = config[:paypal_cancel_url]
