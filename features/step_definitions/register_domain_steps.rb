When /^I try register an available domain$/  do
  stub_get  to: Domain.url(params: { name: 'available.ph' }),
            returns: 'domains/available.ph/get_response'.json

  site.register.load

  site.register.domain_name.set 'available.ph'
  site.register.submit.click

  site.register.registrant.local_name.set             'Registrant'
  site.register.registrant.local_organization.set     'Organization'
  site.register.registrant.local_street.set           'Street'
  site.register.registrant.local_city.set             'City'
  site.register.registrant.local_country_code.select  'Philippines'
  site.register.registrant.voice.set                  '+63.21234567'
  site.register.registrant.email.set                  'registrant@available.ph'
  site.register.registrant.submit.click
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
