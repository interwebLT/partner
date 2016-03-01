Given /^I am not authenticated$/ do
end

When /^I try to authenticate as partner$/ do
  stub_post to: Authorization.url,  returns: 'authorizations/post_response'.json
  stub_get  to: User.url,           returns: 'user/get_partner_response'.json
  stub_get  to: Domain.url,         returns: []

  site.login.load
  site.login.authenticate
end

When /^I try to authenticate as administrator$/ do
  stub_post to: Authorization.url,  returns: 'authorizations/post_response'.json
  stub_get  to: User.url,           returns: 'user/get_admin_response'.json
  stub_get  to: Domain.url,         returns: []

  site.login.load
  site.login.authenticate
end

When /^I try to authenticate with invalid authentication info$/ do
  stub_post to: Authorization.url, returns: 422

  site.login.load
  site.login.authenticate
end

Then /^I must be prompted to authenticate$/ do
  expect(site.login).to be_displayed
end

Then /^I must see the homepage of a partner$/ do
  expect(site.domains).to be_displayed

  expect(site.domains.header).to have_current_balance
  expect(site.domains.header).to have_menu_partner_info
end

Then /^I must see the homepage of an administrator$/ do
  expect(site.domains).to be_displayed

  expect(site.domains.header).not_to have_current_balance
  expect(site.domains.header).not_to have_menu_partner_info
end

Then /^I must be notified that authentication failed$/ do
  expect(site.login).to be_displayed

  expect(site.login.alert.text).to eql 'Failed to Login'
end
