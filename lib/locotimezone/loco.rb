require 'open-uri'
require 'json'

class Loco

  def initialize(address, key)
    @address = address
    @key = key
  end

  def geolocate
    response = open(geolocation_query_url) { |f| JSON.parse f.read }
    format_results(response)
  end

  private 

  def geolocation_query_url
    'https://maps.googleapis.com/maps/api/geocode/json' + '?key=' + @key +
      '&address=' + @address
  end

  def format_results(response)
    response['results'][0]
  end
end
