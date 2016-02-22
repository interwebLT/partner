When /^I register an available domain$/  do
  site.register.load

  site.register.domain_name.set 'available.ph'
  site.register.submit.click
end

Then /^domain must be registered$/  do
  expect(site.register.registrant.domain_name.value).to eql 'available.ph'
end
