class Timezone
  def initialize(location, key)
    @location = location
    @key = key
  end

  def timezone

  end

  private

  def timezone_query_url
    'https://maps.googleapis.com/maps/api/timezone/json'
  end
end
