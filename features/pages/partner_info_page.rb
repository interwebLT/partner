class PartnerInfoPage < SitePrism::Page
  set_url '/partners/{id}'
  set_url_matcher %r{/partners/\d+}

  elements :default_nameservers, '#default_nameservers tbody tr'
  elements :pricing, '#pricing tbody tr'
end
