When /^I try to view my orders$/ do
  stub_get to: Order.url,   returns: 'orders/get_response'.json
  stub_get to: Credit.url,  returns: 'credits/get_response'.json

  site.reports.load
end

When /^I try to view the latest purchases in my zone$/ do
  stub_get to: Order.url, returns: 'orders/get_response'.json

  site.orders.load
end

Then /^I must see my orders$/ do
  expect(site.reports).to be_displayed

  expect(site.reports.orders.count).to eql 6
  expect(site.reports.credits.count).to eql 1
end

Then /^I must see the latest orders$/ do
  expect(site.orders).to be_displayed

  expect(site.orders.header).to have_menu_orders
  expect(site.orders.header.banner_title.text).to eql 'Orders'

  expect(site.orders.orders.count).to eql 6
end
