module Locotimezone
  class Timezone
    attr_reader :location

    def initialize(location)
      @location = location
    end

    def timezone
      return {} if location_invalid?
      response = open(timezone_query_url) { |f| JSON.parse f.read }
    rescue OpenURI::HTTPError
      {}
    else
      format_results response
    end

    private

    def location_invalid?
      return true unless location.respond_to? :has_key?
      location.empty?
    end

    def timezone_query_url
      'https://maps.googleapis.com/maps/api/timezone/json' + '?key=' + 
        Locotimezone.configuration.google_api_key + '&location=' + 
        latitude_longitude + '&timestamp=' + timestamp
    end

    def latitude_longitude
      lat_lng = Array.new
      location.each { |k, v| lat_lng.push v.to_s }
      lat_lng.join(',')
    end

    def timestamp
      Time.now.to_i.to_s
    end

    def format_results(response)
      return {} if response['timeZoneId'].nil?
      Hash[
        timezone_id: response['timeZoneId'], 
        timezone_name: response['timeZoneName']
      ]
    end
  end
end
