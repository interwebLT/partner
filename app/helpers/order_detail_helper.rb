module OrderDetailHelper
  TYPE_DESCRIPTIONS = {
    domain_create:    'Registration',
    domain_renew:     'Renewal',
    transfer_domain:  'Transfer',
    credits:          'Replenish Credits',
    migrate_domain:   'Migrated',
    refund:           'Refund'
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

  def domain_for detail
    if detail.object.nil? || detail.object.id.nil?
      return detail.domain
    end

    return link_to detail.domain, domain_path(detail.object.id)
  end
end
