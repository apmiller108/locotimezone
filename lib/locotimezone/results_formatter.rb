module Locotimezone
  module ResultsFormatter
    def self.build_hash_for(location, timezone)
      {
        geo: location,
        timezone: timezone
      }
    end

    def self.build_timezone_hash_for(timezone)
      return {} if timezone['timeZoneId'].nil?
      {
        timezone_id: timezone['timeZoneId'],
        timezone_name: timezone['timeZoneName']
      }
    end

    def self.build_geolocation_hash_for(location)
      return {} if location['results'].empty?
      {
        formatted_address: location['results'][0]['formatted_address'],
        location: symbolize_keys(location['results'][0]['geometry']['location'])
      }
    end

    def self.symbolize_keys(hash)
      hash.map { |key, value| [key.to_sym, value] }.to_h
    end
  end
end
