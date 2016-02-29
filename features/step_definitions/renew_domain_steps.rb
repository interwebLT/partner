When /^I try to renew a domain$/ do
  stub_get  to: Domain.url,         returns: 'domains/get_response'.json
  stub_get  to: Domain.url(id: 1),  returns: 'domains/1/get_response'.json
  stub_post to: Order.url,          returns: 'orders/post_renew_domain_response'.json

  site.domains.load

  within first('#domains tbody tr') do
    click_on 'Renew'
  end
end

Then /^the domain must be renewed$/ do
end
