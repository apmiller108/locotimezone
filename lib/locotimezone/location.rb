class Location
  attr_reader :key, :address

  def initialize(address, key)
    @address = address
    @key     = key
  end

  def geolocate
    response = open(geolocation_query_url) { |f| JSON.parse f.read }
  rescue OpenURI::HTTPError
    {}
  else
    format_results response
  end

  private 

  def geolocation_query_url
    'https://maps.googleapis.com/maps/api/geocode/json' + '?key=' + key +
      '&address=' + address
  end

  def format_results(response)
    return {} if response['results'].empty?
    Hash[
      formatted_address: response['results'][0]['formatted_address'],
      location: symbolize_keys(response['results'][0]['geometry']['location'])
    ]
  end

  def symbolize_keys(response)
    response.map { |k,v| [k.to_sym, v] }.to_h
  end

end
