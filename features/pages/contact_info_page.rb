class ContactInfoPage < SitePrism::Page
  set_url '/contacts/{id}'
  set_url_matcher %r{/contacts/\d+}

  element :name, '#contact_local_name'
end

def view_contact_info
  stub_get to: Contact.url(id: 1), returns: contact_info_response

  site.contact_info.load(id: 1)

  site.contact_info.name.text.must_equal 'My Local Name'
end

def assert_contact_info_displayed
  site.contact_info.displayed?.must_equal true
end

def contact_info_response
    {:handle=>"contact", :name=>"My Name", :organization=>nil, :street=>nil, :street2=>nil, :street3=>nil, :city=>nil, :state=>nil, :postal_code=>nil, :country_code=>nil, :local_name=>'My Local Name', :local_organization=>nil, :local_street=>nil, :local_street2=>nil, :local_street3=>nil, :local_city=>nil, :local_state=>nil, :local_postal_code=>nil, :local_country_code=>nil, :voice=>nil, :voice_ext=>nil, :fax=>nil, :fax_ext=>nil, :email=>nil}
end