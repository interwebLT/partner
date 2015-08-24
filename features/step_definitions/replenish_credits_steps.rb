When(/^I replenish my credits$/) do
  new_credits
  replenish
end

Then(/^my balance should have changed$/) do
  assert_balance_changed
end

When(/^I try to replenish my credits with an invalid amount$/) do
  new_credits
  replenish amount: 'invalid'
end

Then(/^I should see an error message$/) do
  assert_invalid_amount_error
end