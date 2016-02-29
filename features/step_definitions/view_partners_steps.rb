When /^I try to view a list of all partners$/ do
  stub_get to: Partner.url, returns: 'partners/get_response'.json

  site.partners.load
end

When /^I try to view the info of a partner$/ do
  stub_get to: Partner.url(id: 1), returns: 'partners/1/get_response'.json

  site.partner_info.load id: 1
end

Then /^I must see a list of all partners$/ do
  expect(site.partners).to be_displayed

  expect(site.partners.partners.count).to eql 3
end

Then /^I must see the info of the partner$/ do
  expect(site.partner_info).to be_displayed

  expect(site.partner_info.default_nameservers.count).to eq 2
  expect(site.partner_info.pricing.count).to eq 12
end
