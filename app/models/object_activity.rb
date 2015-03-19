class ObjectActivity
  include Api::Model

  self.resource = 'activities'

  attr_accessor :id, :type, :activity_at, :object,
                :property_changed, :old_value, :new_value

  def object= object
    @object = AppObject.new object
  end
end
