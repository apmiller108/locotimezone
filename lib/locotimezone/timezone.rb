class Timezone
  def initialize(location, key)
    @location = location
    @key = key
  end

  def timezone
    open(timezone_query_url) { |f| JSON.parse f.read }
  end

  private

  def timezone_query_url
    'https://maps.googleapis.com/maps/api/timezone/json' + '?key=' + @key + 
      latitude_longitude
  end

  def latitude_longitude
  end
end
