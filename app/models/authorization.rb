class Authorization
  include Api::Model

  attr_accessor :id, :token

  def self.authenticate username, password
    params = {
      username: username,
      password: password
    }

    begin
      create params
    rescue Api::Model::NotFound
      nil
    end
  end
end
