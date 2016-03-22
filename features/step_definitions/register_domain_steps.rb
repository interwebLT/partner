When /^I try to register an available domain$/  do
  stub_get  to: User.partner_url,
            returns:  'partners/1/get_response'.json

  stub_get  to: Domain.url(params: { name: 'available.ph' }),
            returns: 'domains/available.ph/get_response'.json

  site.register.load

  site.register.domain_name.set 'available.ph'
  site.register.submit.click
end

When /^I provide valid domain details$/ do
  expect(site.register.details).to be_displayed

  stub_post to: Contact.url,
            with:     'contacts/post_request'.json,
            returns:  'contacts/post_response'.json

  stub_get  to: Contact.url(id: '123456789ABCDEF'),
            returns: 'contacts/123456789ABCDEF/get_response'.json

  stub_post to: Order.url,
            with:     'orders/post_register_domain_request'.json,
            returns:  'orders/post_register_domain_response'.json

  site.register.details.submit_valid_details
end

When /^I accept the registration details and charges$/ do
  expect(site.register.summary).to be_displayed

  site.register.summary.submit.click
end

When /^I try to register an available domain in all caps$/  do
  stub_get  to: User.partner_url,
            returns:  'partners/1/get_response'.json

  stub_get  to: Domain.url(params: { name: 'available.ph' }),
            returns: 'domains/available.ph/get_response'.json

  site.register.load

  site.register.domain_name.set 'AVAILABLE.PH'
  site.register.submit.click

  expect(site.register.details).to be_displayed
end

When /^I try to register an existing domain$/  do
  stub_get  to: Domain.url(params: { name: 'existing.ph' }),
            returns: 'domains/existing.ph/get_response'.json

  site.register.load

  site.register.domain_name.set 'existing.ph'
  site.register.submit.click
end

When /^I try to provide the registrant without selecting a domain$/ do
  stub_get  to: User.partner_url,
            returns:  'partners/1/get_response'.json

  site.register.details.load
end

When /^I try to register an invalid domain$/ do
  site.register.load

  site.register.domain_name.set '123'
  site.register.submit.click
end

When /^I provide invalid registrant info$/ do
  expect(site.register.details).to be_displayed

  stub_get  to: Contact.url(id: '123456789ABCDEF'),
            returns:  404

  site.register.details.local_name.set 'Name Only'
  site.register.details.submit.click
end

When /^I try to register a domain that was registered at the same time$/ do
  stub_get  to: User.partner_url,
            returns:  'partners/1/get_response'.json

  stub_get  to: Domain.url(params: { name: 'conflict.ph' }),
            returns: 'domains/conflict.ph/get_response'.json

  stub_post to: Contact.url,
            returns: 'contacts/post_response'.json

  stub_post to: Order.url,
            returns:  422

  stub_get  to: Contact.url(id: '123456789ABCDEF'),
            returns: 'contacts/123456789ABCDEF/get_response'.json

  site.register.details.load domain_name: 'conflict.ph'

  site.register.details.submit_valid_details

  site.register.summary.submit.click
end

When /^I try to provide a registrant with existing handle$/ do
  stub_get  to: User.partner_url,
            returns:  'partners/1/get_response'.json

  stub_get  to: Domain.url(params: { name: 'existing-handle.ph' }),
            returns: 'domains/existing-handle.ph/get_response'.json

  stub_post to: Contact.url,
            returns:  422

  stub_get  to: Contact.url(id: '123456789ABCDEF'),
            returns: 404

  site.register.details.load domain_name: 'existing-handle.ph'

  site.register.details.submit_valid_details
end

When /^I did not accept the domain details as I have a correction$/ do
  expect(site.register.summary).to be_displayed

  stub_get  to: User.partner_url,
            returns:  'partners/1/get_response'.json

  stub_get  to: Domain.url(params: { name: 'available.ph' }),
            returns: 'domains/available.ph/get_response'.json

  stub_get  to: Contact.url(id: '123456789ABCDEF'),
            returns: 'contacts/123456789ABCDEF/get_response'.json

  site.register.summary.cancel.click
end

When /^I try to correct domain details when domain is invalid$/ do
  site.register.details.load domain_name: 'invalid'
end

When /^I try to correct domain details when domain exists$/ do
  stub_get  to: Domain.url(params: { name: 'existing.ph' }),
            returns: 'domains/existing.ph/get_response'.json

  site.register.details.load domain_name: 'existing.ph'
end

When /^I try to correct domain details when period is invalid$/ do
  stub_get  to: User.partner_url,
            returns:  'partners/1/get_response'.json

  stub_get  to: Domain.url(params: { name: 'available.ph' }),
            returns: 'domains/available.ph/get_response'.json

  site.register.details.load  domain_name:  'available.ph',
                              period:       'invalid'
end

When /^I try to correct domain details when registrant is invalid$/ do
  stub_get  to: User.partner_url,
            returns:  'partners/1/get_response'.json

  stub_get  to: Domain.url(params: { name: 'available.ph' }),
            returns: 'domains/available.ph/get_response'.json

  stub_get  to: Contact.url(id: 'invalid'),
            returns: 404

  site.register.details.load  domain_name:  'available.ph',
                              handle:       'invalid'
end

When /^I try to confirm registration details when domain is invalid$/ do
  site.register.summary.load domain_name: 'invalid'
end

When /^I try to confirm registration details when domain exists$/ do
  stub_get  to: Domain.url(params: { name: 'existing.ph' }),
            returns: 'domains/existing.ph/get_response'.json

  stub_get  to: Contact.url(id: '123456789ABCDEF'),
            returns: 'contacts/123456789ABCDEF/get_response'.json

  site.register.summary.load  domain_name:  'existing.ph',
                              period:       '1',
                              handle:       '123456789ABCDEF'
end

When /^I try to confirm registration details when period is invalid$/ do
  stub_get  to: User.partner_url,
            returns:  'partners/1/get_response'.json

  stub_get  to: Domain.url(params: { name: 'available.ph' }),
            returns: 'domains/available.ph/get_response'.json

  site.register.summary.load  domain_name:  'available.ph',
                              period:       'invalid'
end

When /I try to confirm registration details when registrant is invalid$/ do
  stub_get  to: User.partner_url,
            returns:  'partners/1/get_response'.json

  stub_get  to: Domain.url(params: { name: 'available.ph' }),
            returns: 'domains/available.ph/get_response'.json

  stub_get  to: Contact.url(id: 'invalid'),
            returns: 404

  site.register.summary.load  domain_name:  'available.ph',
                              period:       '1',
                              handle:       'invalid'
end

Then /^domain must be registered$/  do
  expect(site.register).to be_displayed

  expect(site.register.notice.text).to eql 'Domain Registered'
end

Then /^I must be notified that domain is not available for registration$/  do
  expect(site.register).to be_displayed

  expect(site.register.alert.text).to eql 'Domain Not Available'
end

Then /^I must be prompted for a valid domain to register$/ do
  expect(site.register).to be_displayed

  expect(site.register).not_to have_notice
  expect(site.register).not_to have_alert
end

Then /^I must be notified that domain is not valid$/ do
  expect(site.register).to be_displayed

  expect(site.register.alert.text).to eql 'Domain Not Valid'
end

Then /^I must be notified that the registrant info is not valid$/ do
  expect(site.register.details).to be_displayed

  expect(site.register.details).to have_warning

  expect(site.register.details.local_name.value).to eql 'Name Only'
end

Then /^I must be notified that domain is no longer available$/ do
  expect(site.register).to be_displayed

  expect(site.register.alert.text).to eql 'Domain Already Registered!'
end

Then /^I must be notified that the registrant already exists$/ do
  expect(site.register.details).to be_displayed

  expect(site.register.details).to have_warning
end

Then /^I must be able to correct my domain details$/ do
  expect(site.register.details).to be_displayed

  expect(site.register.details).not_to have_warning

  expect(site.register.details.domain_name.value).to eql 'available.ph'
  expect(site.register.details.period.value).to eql '2'

  expect(site.register.details.local_name.value).to eql 'Registrant'
  expect(site.register.details.local_organization.value).to eql 'Organization'
  expect(site.register.details.local_street.value).to eql 'Street'
  expect(site.register.details.local_street2.value).to be nil
  expect(site.register.details.local_street3.value).to be nil
  expect(site.register.details.local_city.value).to eql 'City'
  expect(site.register.details.local_state.value).to be nil
  expect(site.register.details.local_postal_code.value).to be nil
  expect(site.register.details.local_country_code.value).to eql 'JP'
  expect(site.register.details.voice.value).to eql '+7.12345'
  expect(site.register.details.voice_ext.value).to be nil
  expect(site.register.details.fax.value).to be nil
  expect(site.register.details.fax_ext.value).to be nil
  expect(site.register.details.email.value).to eql 'registrant@available.ph'
end

Then /^I must provide period as it is blank$/ do
  expect(site.register.details).to be_displayed

  expect(site.register.details).not_to have_warning

  expect(site.register.details.period.value).to be_blank
end

Then /^I must provide registrant info as it is blank$/ do
  expect(site.register.details).to be_displayed

  expect(site.register.details).not_to have_warning

  expect(site.register.details.local_name.value).to be_blank
  expect(site.register.details.local_organization.value).to be_blank
  expect(site.register.details.local_street.value).to be_blank
  expect(site.register.details.local_street2.value).to be_blank
  expect(site.register.details.local_street3.value).to be_blank
  expect(site.register.details.local_city.value).to be_blank
  expect(site.register.details.local_state.value).to be_blank
  expect(site.register.details.local_postal_code.value).to be_blank
  expect(site.register.details.local_country_code.value).to be_blank
  expect(site.register.details.voice.value).to be_blank
  expect(site.register.details.voice_ext.value).to be_blank
  expect(site.register.details.fax.value).to be_blank
  expect(site.register.details.fax_ext.value).to be_blank
  expect(site.register.details.email.value).to be_blank
end
