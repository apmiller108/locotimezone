require 'open-uri'
require 'json'

module Locotimezone
  class LocoTime
    attr_reader :skip, :address
    attr_accessor :location

    def initialize(address:, location:, skip:)
      @location      = location
      @address       = address
      @skip          = location ? :location : skip
      set_default_configuration
    end

    def transform
      validate_options
      location_data = get_location unless skip == :location
      timezone_data = get_timezone unless skip == :timezone
      build_hash(location_data, timezone_data)
    end

    private

    def set_default_configuration
      if Locotimezone.configuration.nil?
        Locotimezone.configure do |config|
          config.google_api_key = ' '
        end
      end
    end

    def validate_options
      if address.nil? && (skip == :timezone || skip.nil?)
        raise ArgumentError, 'locotimezone is missing address or location.'
      end
    end 

    def get_location
      results = Location.new(address).geolocate
      self.location = results[:location] || {}
      results
    end

    def get_timezone
      Timezone.new(location).timezone
    end

    def build_hash(location_data, timezone_data)
      data = Hash.new
      data[:geo]      = location_data unless location_data.nil?
      data[:timezone] = timezone_data unless timezone_data.nil?
      data
    end
  end
end
