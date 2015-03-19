Given /^I am not authenticated$/ do
end

Then /^I try to authenticate as partner$/ do
  partner_authenticated
end

Then /^I try to authenticate as administrator$/ do
  admin_authenticated
end

Then /^I must be prompted to authenticate$/ do
  assert_authentication_prompted
end

Then /^I must see the homepage of a partner$/ do
  assert_partner_homepage_displayed
end

Then /^I must see the homepage of an administrator$/ do
  assert_admin_homepage_displayed
end
