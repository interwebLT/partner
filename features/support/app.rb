class App
  def login
    @login ||= LoginPage.new
  end

  def contacts
    @contacts ||= ContactsPage.new
  end

  def registration
    @registration ||= RegistrationPage.new
  end
  
  def contact_info
    @contact_info ||= ContactInfoPage.new
  end

  def hosts
    @hosts ||= HostsPage.new
  end

  def host_info
    @host_info ||= HostInfoPage.new
  end

  def domains
    @domains ||= DomainsPage.new
  end

  def reports
    @reports ||= ReportsPage.new
  end

  def replenish_credits
    @replenish_credits ||= ReplenishCreditsPage.new
  end

  def domain_info
    @domain_info ||= DomainInfoPage.new
  end

  def profile
    @profile ||= ProfilePage.new
  end

  def partners
    @partners ||= PartnersPage.new
  end

  def activities
    @activities ||= ActivitiesPage.new
  end

  def partner_info
    @partner_info ||= PartnerInfoPage.new
  end

  def orders
    @orders ||= OrdersPage.new
  end
end

def site
  @app ||= App.new
end

def assert_response_message_must_be_not_found

end

def stub_get to:, returns:
  stub_request(:get, to).to_return(body: returns.to_json)
end

def stub_post to:, returns:
  stub_request(:post, to).to_return(status: 201, body: returns.to_json)
end
