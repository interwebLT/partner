class RegisterController < SecureController
  before_filter :staff_only

  def new
  end

  def search
    domain_name = params[:domain_name]

    unless Domain.valid? domain_name
      redirect_to register_path, alert: 'Domain Not Valid'
      return
    end

    unless Domain.exists? domain_name, token: current_user.token
      redirect_to action: :registrant, domain_name: domain_name
    else
      redirect_to register_path, alert: 'Domain Not Available'
    end
  end

  def registrant
    @domain_name = params[:domain_name]

    unless @domain_name.blank?
      @registrant = Contact.new
    else
      redirect_to register_path
    end
  end

  def create
    @domain_name = params[:contact].delete :domain_name
    @registrant = Contact.new params[:contact]

    if @registrant.save token: current_user.token
      register_domain
    else
      render :registrant
    end
  end

  private

  def register_domain
    json_request = {
      currency_code: 'USD',
      ordered_at: DateTime.now.iso8601,
      order_details: [
        {
          type: 'domain_create',
          domain:   @domain_name,
          authcode: 'ABC123',
          period:   1,
          registrant_handle:  @registrant.handle
        }
      ]
    }

    order = Order.new json_request

    begin
      order.save token: current_user.token

      redirect_to register_path, notice: 'Domain Registered'
    rescue Api::Model::UnprocessableEntity
      redirect_to register_path, alert: 'Domain Already Registered!'
    end
  end
end
