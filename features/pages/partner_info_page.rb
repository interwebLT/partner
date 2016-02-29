class PartnerInfoPage < SitePrism::Page
  set_url '/partners/{id}'

  elements :default_nameservers, '#default_nameservers tbody tr'
  elements :pricing, '#pricing tbody tr'
end
