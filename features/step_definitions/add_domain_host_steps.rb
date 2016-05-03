When /^I add a domain host$/  do
  site.domain_info.add_domain_host.click

  expect(site.add_domain_host).to be_displayed

  stub_get  to: Domain.url(id: 1),
            returns: 'domains/1/get_response'.json

  stub_post to: DomainHost.url('domain.ph'),
            with:     'domains/domain.ph/hosts/post_request'.json,
            returns:  'domains/domain.ph/hosts/post_response'.json

  site.add_domain_host.name.set 'ns5.domains.ph'
  site.add_domain_host.submit.click
end

When /^I add a blank domain host$/ do
  site.domain_info.add_domain_host.click

  expect(site.add_domain_host).to be_displayed

  stub_get  to: Domain.url(id: 1),
            returns: 'domains/1/get_response'.json

  site.add_domain_host.name.set ''
  site.add_domain_host.submit.click
end

Then /^domain must now have domain host$/  do
  expect(site.domain_info).to be_displayed
  expect(site.domain_info.notice).to have_attributes text: 'Nameserver added!'
end

Then /^I must be notified that domain host is not valid$/ do
  expect(site.add_domain_host).to be_displayed
  expect(site.add_domain_host.warning).to have_attributes text: 'Some information is missing or incorrect. Please check your entries and try again.'
end
