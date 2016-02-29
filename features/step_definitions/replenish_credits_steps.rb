When /^I replenish my credits$/ do
  stub_get  to: Partner.url,        returns: 'partners/get_response'.json
  stub_get  to: Partner.url(id: 1), returns: 'partners/1/get_response'.json
  stub_post to: Credit.url,         returns: {}

  site.replenish_credits.load id: 1

  fill_in 'credit_amount',  with: '100'
  fill_in 'credit_remarks', with: 'remarks'
  find('input[name=commit]').click
end

Then /^my balance should have changed$/ do
  expect(site.partners).to be_displayed
end
