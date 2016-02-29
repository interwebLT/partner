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
