ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'

class ActiveSupport::TestCase
  class << self
    alias :context :describe
  end

  def default_token
    'abcd123456'
  end

  def default_headers
    { 'Authorization' => "Token token=#{default_token}" }
  end

  def json_response
    assert_response :success

    JSON.parse response.body, symbolize_names: true
  end
end

module Devise
  module TestHelpers
    def authenticate_user(staff: false)
      stub_request(:post, Authorization.url)
        .to_return(body: { id: 1, token: 'abcd123456' }.to_json)

      user_response = {
        id: 1,
        username: 'alpha',
        partner_id: 1,
        token: 'abcd123456',
        partner_name: 'alpha',
        credits: 1000.00,
        admin: false,
        staff: staff
      }

      stub_request(:get, User.url)
        .with(headers: { 'Authorization' => 'Token token=' })
        .to_return(body: user_response.to_json)

      sign_in User.new(username: 'alpha', password: 'password')
    end

    def authenticate_admin
      stub_request(:post, Authorization.url)
        .to_return(body: { id: 1, token: 'abcd123456' }.to_json)

      stub_request(:get, User.url)
        .with(headers: { 'Authorization' => 'Token token=' })
        .to_return(body: { id: 1, username: 'alpha', partner_id: 1, token: 'abcd123456', partner_name: 'alpha', credits: 1000.00, admin: true }.to_json)

      sign_in User.new(username: 'admin', password: 'password')
    end

  end
end

class String
  def to_url params = {}
    "#{self}?#{params.sort.map { |k,v| "#{k}=#{v}" }.join('&')}"
  end
end
