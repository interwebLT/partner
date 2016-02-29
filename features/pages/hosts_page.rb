class HostsPage < SitePrism::Page
  set_url '/hosts'

  section :header, HeaderSection, 'header'

  elements :hosts, '#hosts tbody tr'
end
