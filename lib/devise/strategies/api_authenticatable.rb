module Devise
  module Strategies
    class ApiAuthenticatable < Authenticatable
      def authenticate!
        user = User.authenticate authentication_hash[:username], password

        if user
          success! user
        else
          fail!
        end
      end
    end
  end
end
