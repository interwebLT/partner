class Domain
  include Api::Model

  VALID_EXTENSIONS = ['ph', 'com.ph', 'net.ph', 'org.ph']
  RESTRICTED_EXTENSIONS = ['mil.ph', 'ngo.ph', 'edu.ph', 'gov.ph']

  attr_accessor :id, :zone, :name, :partner, :registered_at, :expires_at,
                :registrant, :registrant_handle, :admin_handle, :billing_handle, :tech_handle,
                :client_hold, :client_delete_prohibited, :client_renew_prohibited,
                :client_transfer_prohibited, :client_update_prohibited,
                :expiring, :expired,
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
    @registrant = Registrant.new registrant
  end

  def activities= activities
    @activities = activities.collect { |activity| ObjectActivity.new activity }
  end

  def hosts= hosts
    @hosts = hosts.collect { |host| DomainHost.new host }
  end

  def self.exists?(name, token:)
    response = get url, { name: name }, token: token

    !response.empty?
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
end
