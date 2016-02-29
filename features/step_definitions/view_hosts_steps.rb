When /^I try to view hosts$/ do
  stub_get to: Host.url, returns: 'hosts/get_response'.json

  site.hosts.load
end

Then /^I must see all hosts$/ do
  expect(site.hosts).to be_displayed

  expect(site.hosts.hosts.count).to eql 3
end

When /^I try to view the info of a host$/ do
  stub_get to: Host.url(id: 1), returns: 'hosts/1/get_response'.json

  site.host_info.load id: 1
end

Then /^I must see the info of the host$/ do
  expect(site.host_info).to be_displayed

  expect(site.host_info.host_addresses.count).to eql 2
end
