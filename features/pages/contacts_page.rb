class ContactsPage < SitePrism::Page
  set_url '/contacts'

  section :header, HeaderSection, 'header'

  elements :contacts, '#contacts tbody tr'
end
