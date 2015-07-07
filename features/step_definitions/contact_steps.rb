When /^I try to view contacts$/ do
  view_contacts
end

Then /^I must see all contacts$/ do
  assert_contacts_displayed
end

