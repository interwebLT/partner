module OrderDetailHelper
  TYPE_DESCRIPTIONS = {
    domain_create:  'Domain Registration',
    domain_renew: 'Domain Renewal',
    transfer_domain:  'Domain Transfer',
    credits:  'Replenish Credits',
    migrate_domain: 'Domain Migrated',
    refund: 'Refund'
  }

  def order_detail_type order_detail_type
    (key = order_detail_type.to_sym) unless order_detail_type.nil?
    (TYPE_DESCRIPTIONS.has_key? key) ? TYPE_DESCRIPTIONS[key] : ''
  end

  def order_detail_duration duration_length, duration_unit
    if duration_length.present? and duration_unit.present?
      "#{duration_length} #{duration_unit.downcase.pluralize(duration_length.to_i)}"
    else
      ""
    end
  end
end
