module Locotimezone
  class Geolocate
    attr_reader :address

    def initialize(address)
      @address = address
    end

    def call
      ResultsFormatter.build_geolocation_hash_for geolocation
    rescue OpenURI::HTTPError => e
      ErrorLogger.stdout_log_for(e, severity: :error)
      {}
    end

    private

    def geolocation
      open(geolocation_query_url) { |f| JSON.parse f.read }
    end

    def geolocation_query_url
      "https://maps.googleapis.com/maps/api/geocode/json?address="\
      "#{address}&key=#{Locotimezone.configuration.google_api_key}"
    end
  end
end
