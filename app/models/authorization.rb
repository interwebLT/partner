class Authorization
  include Api::Model

  attr_accessor :id, :token

  def self.authenticate username, password
    params = {
      username: username,
      password: password
    }

    create params
  rescue Api::Model::NotFound, Api::Model::UnprocessableEntity
    nil
  end
end
