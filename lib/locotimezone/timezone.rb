class Timezone
  attr_reader :key, :location

  def initialize(location, key)
    @location = location
    @key      = key
  end

  def timezone
    response = open(timezone_query_url) { |f| JSON.parse f.read }
    format_results response
  end

  private

  def timezone_query_url
    'https://maps.googleapis.com/maps/api/timezone/json' + '?key=' + key + 
      '&location=' + latitude_longitude + '&timestamp=' + timestamp
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
    Hash[
      timezone_id: response['timeZoneId'], 
      timezone_name: response['timeZoneName']
    ]
  end
end
