When(/^I try to add a host$/) do
  view_domain_info

  add_host
end

Then(/^the host must be added to the domain$/) do
end