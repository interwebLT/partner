module Register
  class RegistrantPage < SitePrism::Page
    set_url '/register/registrant{?domain_name*}'

    element :domain_name, '#domain_name'

    element :local_name,          '#contact_local_name'
    element :local_organization,  '#contact_local_organization'
    element :local_street,        '#contact_local_street'
    element :local_street2,       '#contact_local_street2'
    element :local_street3,       '#contact_local_street3'
    element :local_city,          '#contact_local_city'
    element :local_state,         '#contact_local_state'
    element :local_postal_code,   '#contact_local_postal_code'
    element :local_country_code,  '#contact_local_country_code'
    element :voice,               '#contact_voice'
    element :voice_ext,           '#contact_voice_ext'
    element :fax,                 '#contact_fax'
    element :fax_ext,             '#contact_fax_ext'
    element :email,               '#contact_email'
    element :submit, "input[name='commit']"
  end
end
