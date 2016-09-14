When /^I try to view my domains$/ do
  stub_get to: Domain.url, returns: 'domains/get_response'.json

  site.domains.load
end

When /^I try to view the info of one of my domains$/ do
  stub_get to: Domain.url(id: 1), returns: 'domains/1/get_response'.json

  stub_get  to: "http://test.host/user/partner", returns: 'partners/1/get_response'.json

  stub_get  to: Nameserver.url, returns: 'nameservers/get_response'.json

  site.domain_info.load id: 1
end

Then /^I must see my domains$/ do
  expect(site.domains).to be_displayed

  expect(site.domains.domains.count).to eql 2
end

Then /^I must see the info of my domain$/ do
  expect(site.domain_info).to be_displayed

  expect(site.domain_info.domain_activities).to be_empty
  expect(site.domain_info.domain_hosts).not_to be_empty
end

