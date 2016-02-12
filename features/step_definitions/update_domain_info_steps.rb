When /^I update the registrant of a domain$/ do
  stub_get  to: Domain.url(id: 1),
            returns: 'domains/1/get_response'.json

  site.domain_info.load(id: 1)
end

Then /^domain registrant must be updated$/ do
  pending # Write code here that turns the phrase above into concrete actions
end
