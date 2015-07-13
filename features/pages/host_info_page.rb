class HostInfoPage < SitePrism::Page
  set_url '/hosts/{id}'
  set_url_matcher %r{/hosts/\d+}

  elements :host_addresses, '#addresses li'
end

def view_host_info
  stub_get to: Host.url(id: 1), returns: host_info_response

  site.host_info.load(id: 1)
end

def assert_host_info_displayed
  site.host_info.displayed?.must_equal true
  site.host_info.host_addresses.count.must_equal 2
end

def host_info_response
  {:id=>1, :partner=>"alpha", :name=>"ns5.domains.ph", :host_addresses=>[
    {:address=>"123.456.789.001", :type=>"v4"}, 
    {:address=>"123.456.789.002", :type=>"v4"}
  ], :created_at=>"2015-01-01T00:00:00Z", :updated_at=>"2015-01-01T00:00:00Z"}
end