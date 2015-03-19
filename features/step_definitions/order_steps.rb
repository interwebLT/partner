When /^I try to view my orders$/ do
  view_orders
end

When /^I try to view the latest purchases in my zone$/ do
  view_latest_orders
end

Then /^I must see my orders$/ do
  assert_orders_displayed
end

Then /^I must see the latest orders$/ do
  assert_latest_orders_displayed
end
