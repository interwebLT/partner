Given /^I am viewing a domain$/ do
  stub_get  to: Domain.url(id: 1),
            returns: 'domains/1/get_response'.json

  site.domain_info.load(id: 1)
end

When /^I update the registrant of a domain$/ do
  stub_patch  to: Contact.url(id: 'registrant'),
              returns: 'contacts/registrant/patch_response'.json

  stub_get  to: Domain.url(id: 1),
            returns: 'domains/1/get_after_update_response'.json

  site.domain_info.registrant.local_name.set 'Updated'

  site.domain_info.registrant.submit.click
end

Then /^domain registrant must be updated$/ do
  expect(site.domain_info.registrant.local_name.value).to eql 'Updated'
end
