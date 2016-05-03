When /^I add a domain host$/  do
  site.domain_info.add_domain_host.click

  expect(site.add_domain_host).to be_displayed
end

Then /^domain must now have domain host$/  do
end
