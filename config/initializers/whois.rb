config = Rails.application.config_for(:whois).with_indifferent_access

Rails.configuration.x.whois_url = config[:url]
