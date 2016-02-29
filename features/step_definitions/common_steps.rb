Given /^I am authenticated as staff$/ do
  stub_post to: Authorization.url,  returns: 'authorizations/post_response'.json
  stub_get  to: User.url,           returns: 'user/get_staff_response'.json
  stub_get  to: Domain.url,         returns: []

  site.login.load
  site.login.authenticate
end

Given /^I am authenticated as partner$/ do
  stub_post to: Authorization.url,  returns: 'authorizations/post_response'.json
  stub_get  to: User.url,           returns: 'user/get_partner_response'.json
  stub_get  to: Domain.url,         returns: []

  site.login.load
  site.login.authenticate
end

Given /^I am authenticated as administrator$/ do
  stub_post to: Authorization.url,  returns: 'authorizations/post_response'.json
  stub_get  to: User.url,           returns: 'user/get_admin_response'.json
  stub_get  to: Domain.url,         returns: []

  site.login.load
  site.login.authenticate
end

Then /^error must be not found$/ do
  assert_response_message_must_be_not_found
end
