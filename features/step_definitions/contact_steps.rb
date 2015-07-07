When /^I try to view contacts$/ do
  view_domains
end

Then /^I must see all contacts$/ do
  assert_domains_displayed
end

