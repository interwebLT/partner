When /^I try to view my orders$/ do
  stub_get to: Order.url,   returns: 'orders/get_response'.json
  stub_get to: Credit.url,  returns: 'credits/get_response'.json

  site.reports.load
end

Then /^I must see my orders$/ do
  expect(site.reports).to be_displayed

  expect(site.reports.orders.count).to eql 6
  expect(site.reports.credits.count).to eql 1
end