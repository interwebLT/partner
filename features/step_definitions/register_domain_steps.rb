domain_conflict = false

When(/^I try to register "(.*?)"$/) do |arg1|
  search_domain

  unless domain_conflict
    should_be_on_create_contact_page

    create_contact
  end
end

Given(/^the domain "(.*?)" exists$/) do |arg1|
  domain_conflict = true
  domain_exists
end

Given(/^the domain "(.*?)" does not exist$/) do |arg1|
  domain_does_not_exist
end

Then(/^the order should not be created$/) do
  assert !(page.has_content? 'Order placed')
end

Then(/^I should get a message saying "(.*?)"$/) do |message|
  assert page.has_content? 'Sorry, the domain name you entered is not available or is already taken. Please search again.'
end

Then(/^it should create a new order$/) do
  assert page.has_content? 'Order placed'
end
