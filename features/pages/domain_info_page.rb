class DomainInfoPage < SitePrism::Page
  set_url '/domains/{id}'

  element :notice,  '#notice'
  element :alert,   '#alert'

  element :edit_registrant, '#edit_registrant'
  element :add_domain_host, '#add_domain_host'

  elements :domain_activities, '#domain_activities tbody tr'
  elements :domain_hosts, '#domain_hosts li'
end
