class ContactsPage < SitePrism::Page
  set_url '/contacts'
  set_url_matcher /\/contacts$/

  elements :contacts, '#contacts tbody tr'

  section :header, HeaderSection, 'header'
end

def view_contacts
  stub_get to: Contact.url, returns: contacts_response

  site.contacts.load
end

def assert_contacts_displayed
  site.contacts.displayed?.must_equal true

  site.contacts.contacts.count.must_equal 3
end

private

def contacts_response
  [
    {"handle":"alpha","name":"alpha","organization":nil,"street":nil,"street2":nil,"street3":nil,"city":nil,"state":nil,"postal_code":nil,"country_code":nil,"local_name":nil,"local_organization":nil,"local_street":nil,"local_street2":nil,"local_street3":nil,"local_city":nil,"local_state":nil,"local_postal_code":nil,"local_country_code":nil,"voice":nil,"voice_ext":nil,"fax":nil,"fax_ext":nil,"email":nil},
    {"handle":"Complete","name":"Contact Complete","organization":"Organization Complete","street":"Street","street2":"Street 2","street3":"Street 3","city":"City","state":"State","postal_code":"1234","country_code":"PH","local_name":"Local contact","local_organization":"Local organization","local_street":"Local street","local_street2":"Local street 2","local_street3":"Local street 3","local_city":"Local city","local_state":"Local state","local_postal_code":"Local postal code","local_country_code":"Local country code","voice":"+63.21234567","voice_ext":"1234","fax":"+63.21234567","fax_ext":"1235","email":"Complete@contact.ph"},
    {"handle":"staff","name":"Baxter Staffman","organization":"My Org","street":"1 Main Street","street2":"","street3":"gggdfg","city":"Dark City","state":"","postal_code":"1108","country_code":"US","local_name":"","local_organization":"Gobble","local_street":"","local_street2":"Doop","local_street3":"","local_city":"","local_state":"","local_postal_code":"","local_country_code":"BO","voice":"+63.25555555","voice_ext":"","fax":"","fax_ext":"","email":"miguel@dot.ph"}
  ]
end
