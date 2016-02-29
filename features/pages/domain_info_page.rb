class DomainInfoPage < SitePrism::Page
  set_url '/domains/{id}'

  section :registrant, ContactSection, '#registrant-contact-edit'

  elements :domain_activities, '#domain_activities tbody tr'
  elements :domain_hosts, '#domain_hosts tbody tr'
end
