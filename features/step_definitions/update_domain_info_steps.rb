Given /^I am viewing a domain$/ do
  stub_get  to: Domain.url(id: 1),
            returns: 'domains/1/get_response'.json

  site.domain_info.load(id: 1)
end

When /^I update the registrant of the domain$/ do
  stub_patch  to: Contact.url(id: 'registrant'),
              returns: 'contacts/registrant/patch_response'.json

  stub_get  to: Domain.url(id: 1),
            returns: 'domains/1/get_after_update_response'.json

  site.domain_info.registrant.local_name.set 'Updated'
  site.domain_info.registrant.local_organization.set 'Updated'
  site.domain_info.registrant.local_street.set 'Updated'
  site.domain_info.registrant.local_city.set 'Updated'
  site.domain_info.registrant.voice.set '+63.21000000'
  site.domain_info.registrant.email.set 'updated@alpha.ph'

  site.domain_info.registrant.submit.click
end

When /^I update the registrant of the domain with a blank local name$/ do
  site.domain_info.registrant.local_name.set ''

  site.domain_info.registrant.submit.click
end

When /^I update the registrant of the domain with a blank local organization$/ do
  site.domain_info.registrant.local_organization.set ''

  site.domain_info.registrant.submit.click
end

Then /^error must be validation failed$/ do
  expect(site.domain_info.registrant).to have_error_message
end

Then /^domain registrant must be updated$/ do
  expect(site.domain_info.registrant).not_to have_error_message

  expect(site.domain_info.registrant.local_name.value).to eql 'Updated'
  expect(site.domain_info.registrant.local_organization.value).to eql 'Updated'
  expect(site.domain_info.registrant.local_street.value).to eql 'Updated'
  expect(site.domain_info.registrant.local_city.value).to eql 'Updated'
  expect(site.domain_info.registrant.voice.value).to eql '+63.21000000'
  expect(site.domain_info.registrant.email.value).to eql 'updated@alpha.ph'
end
