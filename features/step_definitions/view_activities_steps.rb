When /^I try to view all activities$/ do
  stub_get to: ObjectActivity.url, returns: 'activities/get_response'.json

  site.activities.load
end

Then /^I must see all activities$/ do
  expect(site.activities).to be_displayed

  expect(site.activities.header).to have_menu_activities
  expect(site.activities.header).to have_banner_title

  expect(site.activities.activities.count).to eql 2
end
