class Credit
  include Api::Model

  attr_accessor :id, :partner, :order_number, :credits, :credited_at, :created_at, :updated_at
end

