When /^I try to view my domains$/ do
  view_domains
end

When /^I try to view the info of one of my domains$/ do
  view_domain_info
end

Then /^I must see my domains$/ do
  assert_domains_displayed
end

Then /^I must see the info of my domain$/ do
  assert_domain_info_displayed
end

