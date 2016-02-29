When /^I try to view my profile information$/ do
  stub_get to: User.partner_url, returns: 'user/partner/get_response'.json

  site.profile.load
end

Then /^I must see my profile information$/ do
  expect(site.profile).to be_displayed

  expect(site.profile.default_nameservers.count).to eql 2
end
