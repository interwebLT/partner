class ContactInfoPage < SitePrism::Page
  set_url '/contacts/{id}'

  element :name, '#contact_local_name'
end
