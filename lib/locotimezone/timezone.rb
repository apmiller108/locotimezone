module Locotimezone
  class Timezone
    attr_reader :location

    def initialize(location)
      @location = location
    end

    def call
      return {} if location_invalid?
      ResultsFormatter.build_timezone_hash_for timezone_response
    rescue OpenURI::HTTPError
      {}
    end

    private

    def timezone_response
      open(timezone_query_url) { |f| JSON.parse f.read }
    end

    def location_invalid?
      return true unless location.respond_to? :has_key?
      location.empty?
    end

    def timezone_query_url
      "https://maps.googleapis.com/maps/api/timezone/json?key="\
      "#{Locotimezone.configuration.google_api_key}&location="\
      "#{comma_delimited_location}&timestamp=#{timestamp}"
    end

    def comma_delimited_location
      location.values.join(',')
    end

    def timestamp
      Time.now.to_i.to_s
    end
  end
end
