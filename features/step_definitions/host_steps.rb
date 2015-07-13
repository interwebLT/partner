When(/^I try to view hosts$/) do
  view_hosts
end

Then(/^I must see all hosts$/) do
  assert_hosts_displayed
end