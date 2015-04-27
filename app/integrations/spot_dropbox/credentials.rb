require 'net/http'
require 'json'

module SpotDropbox
  class Credentials

    def token
      return @token unless @token.blank?
      response = request_token_from_google
      data = JSON.parse(response.body)
      @token = data['access_token']
    end

    def username
      @username ||= Rails.application.secrets.google_username
    end

    def label
      @label ||= ENV["SPOT_GMAIL_LABEL"] || 'SPOT'
    end

    private

    def to_params
      {
        'refresh_token' => Rails.application.secrets.google_refresh_token,
        'client_id' => Rails.application.secrets.google_client_id,
        'client_secret' => Rails.application.secrets.google_client_secret,
        'grant_type' => 'refresh_token'
      }
    end

    def request_token_from_google
      url = URI("https://accounts.google.com/o/oauth2/token")
      Net::HTTP.post_form(url, to_params)
    end
  end
end