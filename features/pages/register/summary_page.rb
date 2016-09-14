module Register
  class SummaryPage < SitePrism::Page
    set_url '/register/summary{?bulk_registration,domain_name,period,handle}'

    element :submit,  "input[name='commit']"
    element :cancel,  '#cancel'
  end
end
