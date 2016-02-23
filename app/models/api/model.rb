module Api
  module Model
    class NotFound < Exception
    end

    class UnprocessableEntity < Exception
    end

    def self.included base
      base.include ActiveModel::Model
      base.extend ClassMethods
    end

    module ClassMethods
      def site
        Rails.configuration.api_url
      end

      def resource
        @resource ||= self.name.downcase.pluralize
      end

      def resource= resource
        @resource = resource
      end

      def url id: nil, params: nil, resource: self.resource
        url = "#{site}/#{resource}"
        (url << "/#{id}") if id
        (url << "?#{params.to_query}") if params

        url
      end

      def default_headers token: ''
        {
          'Authorization' => "Token token=#{token}",
          'Content-Type' => 'application/json',
          'Accept' => 'application/json'
        }
      end

      def process_response response
        case response.code
        when 200, 201
          return JSON.parse response.body, symbolize_names: true
        when 400, 404
          raise Api::Model::NotFound
        when 422
          raise Api::Model::UnprocessableEntity
        end
      end

      def get(url, params = {}, token:)
        process_response HTTParty.get url, query: params, headers: default_headers(token: token)
      end

      def post(url, params, token:)
        process_response HTTParty.post url, body: params.to_json, headers: default_headers(token: token)
      end

      def patch(url, params, token:)
        process_response HTTParty.patch url, body: params.to_json, headers: default_headers(token: token)
      end

      def delete(url, params, token:)
        process_response HTTParty.delete url, body: params.to_json, headers: default_headers(token: token)
      end

      def find(id, token:)
        response = get url(id: id), token: token

        new response
      end

      def create params, token: nil
        new post url, params, token: token
      end

      def all(token:)
        response = get url, token: token

        response.map { |entry| new entry }
      end

      def search(term:,token:)
        response = get url, {search: term}, token: token

        response.map { |entry| new entry }
      end
    end
  end
end
