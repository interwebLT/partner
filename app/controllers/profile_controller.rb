class ProfileController < SecureController
  def index
    @partner = current_user.partner
  end

  def new_partner_nameserver
    nameservers = []
    partner = current_user.partner
    partner.default_nameservers.each do |default_nameserver|
      nameservers << default_nameserver.name
    end
    @current_partner_nameservers = nameservers
  end

  def update_partner_nameserver
    current_nameservers = []
    @partner = current_user.partner
    @partner.default_nameservers.each do |default_nameserver|
      current_nameservers << default_nameserver.name
    end

    new_nameservers = params[:nameservers]

    unless new_nameservers.nil?
      partner_ns_for_add    = new_nameservers - current_nameservers
      partner_ns_for_remove = current_nameservers - new_nameservers

      response = Partner.update_default_nameservers partner_ns_for_remove, partner_ns_for_add, current_user.username, current_user.token

      if response == true
        render json: "true".to_json
      else
        raise "asdfkljhasklfhasklfhahskjdf"
        result = "Something went wrong. Please check."
        render json: result.to_json
      end
    end
  end
end
