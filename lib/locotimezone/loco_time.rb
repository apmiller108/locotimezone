require 'open-uri'
require 'json'
require 'pry'

module Locotimezone
  class LocoTime
    attr_reader :skip, :address, :key
    attr_accessor :location

    def initialize(address:, location:, skip:, key:)
      @location      = location
      @address       = address
      @skip          = skip
      @key           = key || ''
    end

    def transform
      validate_options
      location_data = get_location unless skip == :location
      timezone_data = get_timezone unless skip == :timezone
      build_hash(location_data, timezone_data)
    end

    private

    def validate_options
      if address.nil? && (skip == :timezone || skip.nil?)
        raise ArgumentError, 
          'locotimezone: address is required unless skipping location'
      elsif location.nil? && skip == :location
        raise ArgumentError, 
          'locotimezone: location(lat and lng) is required when skipping'\
          'location'
      end
    end 

    def get_location
      results = Location.new(address, key).geolocate
      self.location = results[:location] || {}
      results
    end

    def get_timezone
      Timezone.new(location, key).timezone
    end

    def build_hash(location_data, timezone_data)
      data = Hash.new
      data[:geo]      = location_data unless location_data.nil?
      data[:timezone] = timezone_data unless timezone_data.nil?
      data
    end

  end
end
