module Register
  class RegistrantPage < SitePrism::Page
    set_url '/register/registrant?domain_name={domain_name}'

    element :domain_name, '#domain_name'
  end
end
