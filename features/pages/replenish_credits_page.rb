class ReplenishCreditsPage < SitePrism::Page
  set_url '/partners/{id}/otc'
  set_url_matcher %r{/partners/\d+/otc}
end

def new_credits
  stub_get to: Partner.url, returns: partners_response
  stub_get to: Partner.url(id: 1), returns: partner_info_response
  stub_post to: "http://test.host/credits", returns: {}

  site.replenish_credits.load(id: 1)
end

def replenish amount: '100', remarks: 'remarks'
  fill_in 'credit_amount', with: amount
  fill_in 'credit_remarks', with: remarks
  find('input[name=commit]').click
end

def assert_invalid_amount_error
  assert page.has_content? 'Invalid amount'
end

def assert_balance_changed
  assert_partners_displayed
end