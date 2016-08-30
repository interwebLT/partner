Given /^I am viewing a domain$/ do
  stub_get  to: Domain.url(id: 1),
            returns: 'domains/1/get_response'.json

  stub_get  to: "http://test.host/user/partner", returns: 'partners/1/get_response'.json

  stub_get  to: Nameserver.url,
            returns: 'nameservers/get_response'.json

  site.domain_info.load id: 1
end

When /^I update the registrant of the domain$/ do
  stub_get  to: Contact.url(id: 'registrant'),
            returns: 'contacts/registrant/get_response'.json

  stub_patch  to: Contact.url(id: 'registrant'),
              with:     'contacts/registrant/patch_request'.json,
              returns:  'contacts/registrant/patch_response'.json

  site.domain_info.edit_registrant.click

  expect(site.contact_info).to be_displayed id: 'registrant'

  site.contact_info.local_name.set 'Updated'
  site.contact_info.local_organization.set 'Updated'
  site.contact_info.local_street.set 'Updated'
  site.contact_info.local_city.set 'Updated'
  site.contact_info.voice.set '+63.21000000'
  site.contact_info.email.set 'updated@alpha.ph'

  site.contact_info.submit.click
end

When /^I update the registrant of the domain with a (.*)$/ do |scenario|
  stub_get  to: Contact.url(id: 'registrant'),
            returns: 'contacts/registrant/get_response'.json

  site.domain_info.edit_registrant.click

  expect(site.contact_info).to be_displayed id: 'registrant'

  data = {
    'blank local name'          => { local_name:  '' },
    'blank local organization'  => { local_organization:  '' }
  }[scenario]

  data.keys.each do |field|
    site.contact_info.send(field).set data[field]
  end

  site.contact_info.submit.click
end

Then /^error must be validation failed$/ do
  expect(site.contact_info).to be_displayed id: 'registrant'

  expect(site.contact_info).to have_warning
end

Then /^domain registrant must be updated$/ do
  expect(site.domain_info).to be_displayed id: 1

  expect(site.domain_info.notice).to have_attributes text:'Contact was updated!'
  expect(site.domain_info).not_to have_alert
end
