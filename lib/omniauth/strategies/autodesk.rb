require 'omniauth-oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    class Autodesk < OmniAuth::Strategies::OAuth2
      option :name, "autodesk"
      option :client_options, {
        :site => 'https://developer.api.autodesk.com',
        :authorize_url => 'https://developer.api.autodesk.com/authentication/v1/authorize',
        :token_url => 'https://developer.api.autodesk.com/authentication/v1/gettoken' }

      def request_phase
        super
      end

      uid { raw_info["userId"] }

      info do
        {
          first_name: raw_info['firstName'],
          last_name: raw_info['lastName'],
          username: raw_info['userName'],
          email: raw_info['emailId'],
          country: raw_info['countryCode'],
          language: raw_info['language']
        }
      end

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        @raw_info ||= MultiJson.decode(access_token.get('/userprofile/v1/users/@me').body)
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

OmniAuth.config.add_camelization 'autodesk', 'Autodesk'
