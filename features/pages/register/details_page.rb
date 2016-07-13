module Register
  class DetailsPage < SitePrism::Page
    set_url '/register/details{?bulk_registration,domain_name,period,handle}'

    element :warning, '#warning'

    element :domain_name, '#registration_form_domain_name'
    element :period,      '#registration_form_period'

    element :local_name,          '#registration_form_local_name'
    element :local_organization,  '#registration_form_local_organization'
    element :local_street,        '#registration_form_local_street'
    element :local_street2,       '#registration_form_local_street2'
    element :local_street3,       '#registration_form_local_street3'
    element :local_city,          '#registration_form_local_city'
    element :local_state,         '#registration_form_local_state'
    element :local_postal_code,   '#registration_form_local_postal_code'
    element :local_country_code,  '#registration_form_local_country_code'
    element :voice,               '#registration_form_voice'
    element :voice_ext,           '#registration_form_voice_ext'
    element :fax,                 '#registration_form_fax'
    element :fax_ext,             '#registration_form_fax_ext'
    element :email,               '#registration_form_email'
    element :submit,              "input[name='commit']"

    def enter_valid_details
      self.period.select              '2'

      self.local_name.set             'Registrant'
      self.local_organization.set     'Organization'
      self.local_street.set           'Street'
      self.local_city.set             'City'
      self.local_country_code.select  'Japan'
      self.voice.set                  '+7.12345'
      self.email.set                  'registrant@available.ph'
    end
  end
end