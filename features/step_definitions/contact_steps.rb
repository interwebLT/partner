When /^I try to view contacts$/ do
  stub_get to: Contact.url, returns: 'contacts/get_response'.json

  site.contacts.load
end

Then /^I must see all contacts$/ do
  expect(site.contacts).to be_displayed

  expect(site.contacts.contacts.count).to eql 3
end

When /^I try to view the info of a contact$/ do
  stub_get to: Contact.url(id: 'registrant'), returns: 'contacts/registrant/get_response'.json

  site.contact_info.load id: 'registrant'
end

Then /^I must see the info of the contact$/ do
  expect(site.contact_info).to be_displayed

  expect(site.contact_info.name.text).to eql 'Name'
end

