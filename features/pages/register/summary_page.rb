class Register::SummaryPage < SitePrism::Page
  set_url '/register/summary{?domain_name*}'

  element :submit,  "input[name='commit']"
  element :cancel,  '#cancel'
end
