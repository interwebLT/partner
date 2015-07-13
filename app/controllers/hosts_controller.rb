class HostsController < ApplicationController
  def index
    @hosts = Host.all token: current_user.token
  end
end
