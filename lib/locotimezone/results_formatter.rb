module Locotimezone
  module ResultsFormatter
    def self.build_hash_for(location, timezone)
      {
        geo: location,
        timezone: timezone
      }
    end
  end
end
