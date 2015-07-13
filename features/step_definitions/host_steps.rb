When(/^I try to view hosts$/) do
  view_hosts
end

Then(/^I must see all hosts$/) do
  assert_hosts_displayed
end

When(/^I try to view the info of a host$/) do
  view_host_info
end

Then(/^I must see the info of the host$/) do
  assert_host_info_displayed
end