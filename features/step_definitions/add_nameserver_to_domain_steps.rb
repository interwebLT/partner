When /^I try to add a host$/ do
  stub_get  to: Domain.url(id: 1), returns: 'domains/1/get_response'.json

  stub_post to: 'http://test.host/domains/1/hosts',
            returns: 'domains/1/hosts/post_response'.json

  site.domains.load id: 1

  within first('#new_domain_host') do
    fill_in 'domain_host_name', with: 'ns5.domains.ph'
    click_on 'Create Domain host'
  end
end

Then /^the host must be added to the domain$/ do
end
