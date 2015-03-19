Given /^I am authenticated as partner$/ do
  partner_authenticated
end

Given /^I am authenticated as administrator$/ do
  admin_authenticated
end

Then /^error must be not found$/ do
  assert_response_message_must_be_not_found
end
