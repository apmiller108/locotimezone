require 'open-uri'
require 'json'

class LocoTime
  def initialize(address, options = {})
    @address  = address
    @key      = options.fetch(:key, ENV['GOOGLE_API_KEY'])
  end

  def run_query
    Hash[
      formatted_address: get_location['formatted_address'],
      location: get_location['geometry']['location']
    ]
  end

  private

  def get_location
    return @location if defined? @location
    @location = open(geolocation_query_url) { |f| JSON.parse f.read }
    format_results
  end

  def format_results
    @location = @location['results'][0]
  end

  def timezone_query_url
    'https://maps.googleapis.com/maps/api/timezone/json'
  end

  def geolocation_query_url
    'https://maps.googleapis.com/maps/api/geocode/json' + '?key=' + @key +
      '&address=' + @address
  end

end
