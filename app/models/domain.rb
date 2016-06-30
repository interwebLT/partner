class Domain
  include Api::Model

  VALID_EXTENSIONS = ['ph', 'com.ph', 'net.ph', 'org.ph']
  RESTRICTED_EXTENSIONS = ['mil.ph', 'ngo.ph', 'edu.ph', 'gov.ph']

  attr_accessor :id, :zone, :name, :partner, :registered_at, :expires_at,
                :registrant_handle, :admin_handle, :billing_handle, :tech_handle,
                :registrant, :admin_contact, :billing_contact, :tech_contact,
                :client_hold, :client_delete_prohibited, :client_renew_prohibited,
                :client_transfer_prohibited, :client_update_prohibited,
                :server_hold, :server_delete_prohibited, :server_renew_prohibited,
                :server_transfer_prohibited, :server_update_prohibited,
                :expiring, :expired, :powerdns_domain, :powerdns_records,
                :activities, :hosts

  def expired?
    expired
  end

  def expiring?
    expiring
  end

  def persisted?
    id.present?
  end

  def registrant= registrant
    @registrant = Contact.new registrant
  end

  def admin_contact= admin_contact
    @admin_contact = Contact.new admin_contact
  end

  def billing_contact= admin_contact
    @billing_contact = Contact.new admin_contact
  end

  def tech_contact= admin_contact
    @tech_contact = Contact.new admin_contact
  end

  def activities= activities
    @activities = activities.collect { |activity| ObjectActivity.new activity }
  end

  def hosts= hosts
    @hosts = hosts.collect { |host| DomainHost.new host }
  end

  def powerdns_domain= powerdns_domain
    @powerdns_domain = Powerdns::Domain.new powerdns_domain
  end

  def powerdns_records= powerdns_records
    @powerdns_records = powerdns_records.collect { |record| Powerdns::Record.new record }
  end

  def self.exists?(name, token:)
    response = nil

    begin
      response ||= Whois.find name, token: token
    rescue Api::Model::NotFound
    end

    begin
      response ||= GlobalWhois.find name, token: token
    rescue Api::Model::NotFound
    end

    !response.nil?
  end

  def self.valid? domain_name
    return false if domain_name.blank?
    return false if VALID_EXTENSIONS.include? domain_name
    return false if RESTRICTED_EXTENSIONS.include? domain_name

    root_name = domain_name.split('.', 2)[0]
    extension = domain_name.split('.', 2)[1]

    return false if extension.blank?

    too_short = (root_name.length < 3)
    too_long = (root_name.length > 63)
    special_chars = (root_name =~ /^[a-zA-Z0-9-]*$/).nil?
    invalid_extension = (not VALID_EXTENSIONS.include? extension)
    numbers_only = !(root_name =~ /^[0-9]*$/).nil?
    starts_with_dash = !(root_name =~ /^-/).nil?
    double_dash = root_name.include? '--'

    not (too_short or too_long or special_chars or invalid_extension \
      or numbers_only or starts_with_dash or double_dash)
  end

  def renew token:
    order = Order.new( {
      partner: nil,
      currency_code: 'USD'
    } )
    order.partner = partner

    detail = {
      type: 'domain_renew',
      domain: name,
      authcode: nil,
      period: 1,
      registrant_handle: registrant_handle,
      registered_at: registered_at
      }
    order.order_details = [detail]

    return order.save token: token
  end

  def domain_owner
    registrant.name.present? ? registrant.name : registrant.local_name
  end

  def renew_allowed?
    target_expires_at = self.expires_at.in_time_zone + 1.year
    max_expires_at    = Time.current + 10.years

    target_expires_at <= max_expires_at
  end

  def matched_nameserver? nameservers
    if @hosts.count != nameservers.count
      false
    else
      @hosts.each do |host|
        output = nameservers.map{|nameserver| nameserver.name}.include?(host.name.strip)
        break if !output
      end
    end
  end
end