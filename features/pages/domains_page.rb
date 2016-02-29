class DomainsPage < SitePrism::Page
  set_url '/domains'

  section :header, HeaderSection, 'header'

  elements :domains, '#domains tbody tr'
  elements :renew_buttons, '#domains tbody tr td a .renew'
end
