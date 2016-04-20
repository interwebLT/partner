When /^I remove a domain host$/ do
  expect(site.domain_info.domain_hosts).to have_attributes count: 2

  stub_delete to: DomainHost.url('domain.ph', id: 'ns5.domains.ph'),
              returns: 'domains/domain.ph/hosts/ns5.domains.ph/delete_response'.json

  page.driver.delete '/domains/domain.ph/hosts/ns5.domains.ph'
end

When /^I remove a domain host that does not exist$/ do
  expect(site.domain_info.domain_hosts).to have_attributes count: 2

  stub_delete to: DomainHost.url('domain.ph', id: 'ns5.domains.ph'),
              returns: 404

  page.driver.delete '/domains/domain.ph/hosts/ns5.domains.ph'
end

Then /^domain host must be removed$/ do
end
