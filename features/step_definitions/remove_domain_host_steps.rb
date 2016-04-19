When /^I remove a domain host$/ do
  stub_get  to: Domain.url(id: 1),
            returns: 'domains/1/get_response'.json

  stub_delete to: DomainHost.url('domain.ph', id: 1),
              returns: 'domains/1/hosts/1/delete_response'.json

  page.driver.delete '/domains/1/hosts/1'
end

When /^I remove a domain host that does not exist$/ do
  stub_get  to: Domain.url(id: 1),
            returns: 'domains/1/get_response'.json

  stub_delete to: DomainHost.url('domain.ph', id: 1),
              returns: 404

  page.driver.delete '/domains/1/hosts/1'
end

Then /^domain host must be removed$/ do
end
