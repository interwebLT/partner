When /^I try to view contacts$/ do
  view_contacts
end

Then /^I must see all contacts$/ do
  assert_contacts_displayed
end

When /^I try to view the info of a contact$/ do
  view_contact_info
end

Then /^I must see the info of the contact$/ do
  assert_contact_info_displayed
end

