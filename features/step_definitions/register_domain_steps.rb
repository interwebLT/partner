When /^I register an available domain$/  do
  site.register.load

  site.register.domain_name.set 'available.ph'
  site.register.submit.click

  site.register.registrant.local_name.set         'Registrant'
  site.register.registrant.local_organization.set 'Organization'
  site.register.registrant.local_street.set       'Street'
  site.register.registrant.local_city.set         'City'
  site.register.registrant.local_country_code.set 'XX'
  site.register.registrant.voice.set              '+63.21234567'
  site.register.registrant.email.set              'registrant@available.ph'
  site.register.registrant.submit.click
end

Then /^domain must be registered$/  do
  expect(site.register.notice.text).to eql 'Domain Registered'
end
