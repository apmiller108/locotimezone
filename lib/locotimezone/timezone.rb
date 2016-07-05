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
      '&location=' + latitude_longitude + '&timestamp=' + timestamp
  end

  def latitude_longitude
    lat_lng = []
    @location[:location].each { |k, v| lat_lng.push v.to_s }
    lat_lng.join(',')
  end

  def timestamp
    Time.now.to_i.to_s
  end
end
