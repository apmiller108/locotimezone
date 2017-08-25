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
  end
end
