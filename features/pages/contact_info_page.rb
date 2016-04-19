class ContactInfoPage < SitePrism::Page
  set_url '/contacts/{id}'

  element :warning, "#warning"

  element :local_name,          "input[name='contact[local_name]']"
  element :local_organization,  "input[name='contact[local_organization]']"
  element :local_street,        "input[name='contact[local_street]']"
  element :local_city,          "input[name='contact[local_city]']"
  element :local_country_code,  "select[name='contact[local_country_code]']"
  element :voice,               "input[name='contact[voice]']"
  element :email,               "input[name='contact[email]']"
  element :submit,              '#submit'
end
