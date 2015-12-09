class Partner
  include Api::Model

  attr_accessor :id, :name, :organization, :credits, :site,
                :nature, :representative, :position,
                :street, :city, :state, :postal_code, :country_code, :phone, :fax, :email,
                :local, :admin,
                :default_nameservers, :pricing

  def persisted?
    id.present?
  end

  def default_nameservers= default_nameservers
    @default_nameservers = default_nameservers.collect do |default_nameserver|
      DefaultNameserver.new default_nameserver
    end
  end

  def pricing= pricing
    @pricing = pricing.collect { |price| PartnerPricing.new price }
  end

  def replenish_credits amount, remarks, token, type='credits', authcode=nil
    order = Order.new( {
      partner: nil,
      currency_code: 'USD'
    } )
    order.partner = name

    detail = {
      type: type,
      credits: amount,
      authcode: authcode,
      remarks: remarks
    }
    order.order_details = [detail]

    return Credit.post Credit.url, order.to_json, token: token
  end
end
