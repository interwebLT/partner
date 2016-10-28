class RegisterController < SecureController
  def new
    if params[:list]
      @entered_domains = params[:list]
    else
      @entered_domains = ""
    end
    @domains = Domain.all token: current_user.token
  end

  def search
    params[:bulk_registration] = true

    if params[:bulk_registration] && !params[:domain_name].empty?
      domain_names = params[:domain_name].split
      valid_domain = true

      domain_names.each do |domain_name|
        domain = domain_name.strip.downcase
        if not Domain.valid? domain
          valid_domain = false
          redirect_to register_path(list: params[:domain_name]),
            alert: "Domain names must have at least 3 characters (not including the extension) and a maximum of 63 (excluding the extension). Characters allowed are [a-z], [0-9] and [-]. Domains must not start or end with a dash [-] or have simultaneous dashes, and must not contain embedded spaces. Names with only numeric characters will not be accepted. Valid extensions are ph, com.ph, net.ph, and org.ph."
          break
        elsif not Domain.exists? domain, token: auth_token
        else
          valid_domain = false
          redirect_to register_path(list: params[:domain_name]),
            alert: "Domain #{domain} is not available."
          break
        end
      end

      if valid_domain
        redirect_to action: :details, domain_name: domain_names.join(", "),
          bulk_registration: params[:bulk_registration]
      end
    else
      redirect_to register_path, alert: "Please enter a valid Domain."
    end
  end

  def details
    @registration = RegistrationForm.new request_params
    @registration.registrant = registrant if @registration.handle

    if params[:bulk_registration] && !params[:domain_name].empty?
      domain_names  = params[:domain_name].split(',')
      @pricing      = current_user.partner.pricing.map{|pricing| [pricing.period, pricing.price]}.to_h.to_json
      @total_credit = current_user.credits.to_f + current_user.partner.credit_limit.to_f
      @domain_count = domain_names.count

      valid_domain = true

      domain_names.each do |domain_name|
        domain = domain_name.strip.downcase
        if not Domain.valid? domain
          valid_domain = false
          redirect_to register_path
          break
        elsif not Domain.exists? domain, token: auth_token
        else
          valid_domain = false
          redirect_to register_path, alert: "Domain #{domain} is no longer available."
          break
        end
      end

      if valid_domain
        @partner = current_user.partner
        @bulk_registration = params[:bulk_registration]
      end
    else
      if not Domain.valid? @registration.domain_name
        redirect_to register_path
      elsif not Domain.exists? @registration.domain_name, token: auth_token
        @partner = current_user.partner
      else
        redirect_to register_path, alert: "Domain #{@registration.domain_name} is no longer available."
      end
    end
  end

  def create_registrant
    domain_saved = true
    bulk_handle_list = []
    @registration = RegistrationForm.new registration_params

    if params[:bulk_registration]
      domain_names = registration_params[:domain_name].split(',')

      domain_names.each do |domain_name|
        domain = domain_name.strip.downcase
        @registration.domain_name = domain
        if @registration.save_registrant token: auth_token
          bulk_handle_list << @registration.registrant.handle
          domain_saved = true
        else
          domain_saved = false
          break
        end
      end
    else
      if @registration.save_registrant token: auth_token
        domain_saved = true
      else
        domain_saved = false
      end
    end

    if domain_saved
      if params[:bulk_registration]
        domain  = domain_names.join(',')
        handle  = bulk_handle_list.join(',')
        bulk    = true
      else
        domain  = @registration.domain_name
        handle  = @registration.registrant.handle
        bulk    = false
      end
      redirect_to action: :summary, domain_name:        domain,
                                    period:             @registration.period,
                                    handle:             handle,
                                    bulk_registration:  bulk
    else
      @partner = current_user.partner
      render :details
    end
  end

  def summary
    validate_domain = ""
    bulk_handle_list = []
    @registration = RegistrationForm.new request_params
    if params[:bulk_registration]
      domain_names = params[:domain_name].split(',')
      handles      = params[:handle].split(',')

      domain_names.each_with_index do |domain_name, key|
        domain = domain_name.strip.downcase
        @registration.domain_name = domain
        @registration.handle      = handles[key]
        params[:handle] = handles[key]
        bulk_handle_list << handles[key]
        @registration.registrant = registrant if @registration.handle

        if not Domain.valid? @registration.domain_name
          validate_domain = "domain_invalid"
          break
        elsif Domain.exists? @registration.domain_name, token: auth_token
          validate_domain = "domain_exist"
          break
        elsif not @registration.valid?
          validate_domain = "registration_invalid"
          break
        else
          validate_domain = "passed"
        end
      end
    else
      @registration.registrant = registrant if @registration.handle

      if not Domain.valid? @registration.domain_name
        validate_domain = "domain_invalid"
      elsif Domain.exists? @registration.domain_name, token: auth_token
        validate_domain = "domain_exist"
      elsif not @registration.valid?
        validate_domain = "registration_invalid"
      else
        validate_domain = "passed"
      end
    end

    case validate_domain
      when "domain_invalid"
        redirect_to register_path
      when "domain_exist"
        redirect_to register_path, alert: "Domain #{@registration.domain_name} is no longer available."
      when "registration_invalid"
        if params[:bulk_registration]
          domain  = domain_names.join(',')
          handle  = bulk_handle_list.join(',')
          bulk    = true
        else
          domain  = @registration.domain_name
          handle  = @registration.registrant.handle
          bulk    = false
        end
        redirect_to action: :details, domain_name:        domain,
                                      period:             @registration.period,
                                      handle:             handle,
                                      bulk_registration:  bulk
      when "passed"
        if params[:bulk_registration]
          params[:handle] = handles.join(',')
          @bulk_registration = params[:bulk_registration]
          @registration.domain_name = domain_names.join(',')
          @registration.handle = handles.join(',')
        end
        @partner = current_user.partner
    end
  end

  def create_order
    domain_saved = true
    registration = RegistrationForm.new registration_params
    if params[:bulk_registration]
      domain_names = registration_params[:domain_name].split(',')
      handles      = registration_params[:handle].split(',')

      domain_names.each_with_index do |domain_name, key|
        domain = domain_name.strip.downcase
        registration.domain_name = domain
        registration.handle      = handles[key]

        if registration.order.save token: auth_token
          current_user.partner.default_nameservers.each do |nameserver|
            domain_host = DomainHost.new  domain: registration.domain_name,
                                          name:   nameserver.name
            domain_host.save token: auth_token
          end
        else
          domain_saved = false
          break
        end
      end
    else
      if registration.order.save token: auth_token
        current_user.partner.default_nameservers.each do |nameserver|
          domain_host = DomainHost.new  domain: registration.domain_name,
                                        name:   nameserver.name
          domain_host.save token: auth_token
        end
      else
        domain_saved = false
      end
    end

    if domain_saved
      redirect_to register_path, notice: 'Domain(s) Registered'
    else
      redirect_to register_path, alert: "Domain #{registration.domain_name} is no longer available."
    end
  end

  private

  def registration_params
    params.require(:registration_form).permit :domain_name, :period, :handle,
                                              :local_name, :local_organization, :local_street, :local_street2, :local_street3,
                                              :local_city, :local_state, :local_postal_code, :local_country_code,
                                              :voice, :voice_ext, :fax, :fax_ext, :email
  end

  def request_params
    params.permit :domain_name, :period, :handle, :bulk_registration
  end

  def registrant
    Contact.find params[:handle], token: auth_token
  rescue Api::Model::NotFound
    Contact.new
  end
end
