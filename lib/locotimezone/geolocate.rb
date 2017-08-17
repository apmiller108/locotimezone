module Locotimezone
  class Geolocate
    attr_reader :address

    def initialize(address)
      @address = address
    end

    def get_geo
      response = open(geolocation_query_url) { |f| JSON.parse f.read }
    rescue OpenURI::HTTPError
      {}
    else
      format_results response
    end

    private 

    def geolocation_query_url
      'https://maps.googleapis.com/maps/api/geocode/json' + '?address=' + 
        address.to_s + '&key=' + Locotimezone.configuration.google_api_key
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
end
