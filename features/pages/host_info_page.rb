class HostInfoPage < SitePrism::Page
  set_url '/hosts/{id}'

  elements :host_addresses, '#addresses li'
end
