class HostsPage < SitePrism::Page
  set_url '/hosts'
  set_url_matcher /\/hosts$/

  elements :hosts, '#hosts tbody tr'

  section :header, HeaderSection, 'header'
end

def view_hosts
  stub_get to: Host.url, returns: hosts_response

  site.hosts.load
end

def assert_hosts_displayed
  site.hosts.displayed?.must_equal true

  site.hosts.hosts.count.must_equal 3
end

private

def hosts_response
  [{:id=>1, :partner=>"admin", :name=>"ns3.domains.ph", :host_addresses=>[], :created_at=>"2015-01-01T00:00:00Z", :updated_at=>"2015-01-01T00:00:00Z"}, 
  {:id=>2, :partner=>"admin", :name=>"ns4.domains.ph", :host_addresses=>[], :created_at=>"2015-01-01T00:00:00Z", :updated_at=>"2015-01-01T00:00:00Z"}, 
  {:id=>3, :partner=>"alpha", :name=>"ns5.domains.ph", :host_addresses=>[
      {:address=>"123.456.789.001", :type=>"v4"}, 
      {:address=>"123.456.789.002", :type=>"v4"}
  ], :created_at=>"2015-01-01T00:00:00Z", :updated_at=>"2015-01-01T00:00:00Z"}]
end