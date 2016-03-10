module Register
  class DetailsPage < SitePrism::Page
    set_url '/register/details{?domain_name*}'

    element :warning, '#warning'

    element :domain_name, '#registration_domain'

    element :local_name,          '#registration_local_name'
    element :local_organization,  '#registration_local_organization'
    element :local_street,        '#registration_local_street'
    element :local_street2,       '#registration_local_street2'
    element :local_street3,       '#registration_local_street3'
    element :local_city,          '#registration_local_city'
    element :local_state,         '#registration_local_state'
    element :local_postal_code,   '#registration_local_postal_code'
    element :local_country_code,  '#registration_local_country_code'
    element :voice,               '#registration_voice'
    element :voice_ext,           '#registration_voice_ext'
    element :fax,                 '#registration_fax'
    element :fax_ext,             '#registration_fax_ext'
    element :email,               '#registration_email'
    element :submit,              "input[name='commit']"

    def submit_valid_details
      self.local_name.set             'Registrant'
      self.local_organization.set     'Organization'
      self.local_street.set           'Street'
      self.local_city.set             'City'
      self.local_country_code.select  'Japan'
      self.voice.set                  '+7.12345'
      self.email.set                  'registrant@available.ph'

      self.submit.click
    end
  end
end
