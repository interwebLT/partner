config = Rails.application.config_for(:invoice).with_indifferent_access

Rails.configuration.invoice_logo = config[:logo]
Rails.configuration.invoice_organization_name = config[:organization_name]
Rails.configuration.invoice_address1 = config[:address1]
Rails.configuration.invoice_address2 = config[:address2]
Rails.configuration.invoice_address3 = config[:address3]
Rails.configuration.invoice_phone = config[:phone]
