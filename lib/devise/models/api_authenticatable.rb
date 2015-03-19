module Devise
  module Models
    module ApiAuthenticatable
      extend ActiveSupport::Concern

      module ClassMethods
        def serialize_from_session key, salt
          User.info token: key
        end

        def serialize_into_session record
          [record.token, nil]
        end
      end
    end
  end
end
