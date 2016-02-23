When /^I try register an available domain$/  do
  stub_get  to: Domain.url(params: { name: 'available.ph' }),
            returns: 'domains/available.ph/get_response'.json

  stub_post to: Contact.url,
            returns: 'contacts/registrant/post_response'.json

  stub_post to: Order.url,
            returns: 'domains/available.ph/post_response'.json

  site.register.load

  site.register.domain_name.set 'available.ph'
  site.register.submit.click

  site.register.registrant.submit_valid_registrant
end

When /^I try register an existing domain$/  do
  stub_get  to: Domain.url(params: { name: 'existing.ph' }),
            returns: 'domains/existing.ph/get_response'.json

  site.register.load

  site.register.domain_name.set 'existing.ph'
  site.register.submit.click
end

When /^I try to provide the registrant without selecting a domain$/ do
  site.register.registrant.load
end

When /^I try to register an invalid domain$/ do
  site.register.load

  site.register.domain_name.set '123'
  site.register.submit.click
end

When /^I try to register a domain with invalid registrant info$/ do
  site.register.registrant.load domain_name: 'available.ph'

  site.register.registrant.submit.click
end

When /^I try to register a domain that was registered at the same time$/ do
  stub_post to: Contact.url,
            returns: 'contacts/registrant/post_response'.json

  stub_post to: Order.url, returns: 422

  site.register.registrant.load domain_name: 'conflict.ph'

  site.register.registrant.submit_valid_registrant
end

When /^I try to provide a registrant with existing handle$/ do
  stub_post to: Contact.url, returns: 422

  site.register.registrant.load domain_name: 'existing_handle.ph'

  site.register.registrant.submit_valid_registrant
end

Then /^domain must be registered$/  do
  expect(site.register).to be_displayed

  expect(site.register.notice.text).to eql 'Domain Registered'
end

Then /^I must be notified that domain is not available for registration$/  do
  expect(site.register).to be_displayed

  expect(site.register.alert.text).to eql 'Domain Not Available'
end

Then /^I must be first asked a domain to register$/ do
  expect(site.register).to be_displayed

  expect(site.register).not_to have_notice
  expect(site.register).not_to have_alert
end

Then /^I must be notified that domain is not valid$/ do
  expect(site.register).to be_displayed

  expect(site.register.alert.text).to eql 'Domain Not Valid'
end

Then /^I must be notified that the registrant info is not valid$/ do
  expect(site.register.registrant).to be_displayed

  expect(site.register.registrant).to have_warning
end

Then /^I must be notified that domain is no longer available$/ do
  expect(site.register).to be_displayed

  expect(site.register.alert.text).to eql 'Domain Already Registered!'
end

Then /^I must be notified that the registrant already exists$/ do
  expect(site.register.registrant).to be_displayed

  expect(site.register.registrant).to have_warning
end
