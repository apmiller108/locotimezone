require 'open-uri'
require 'json'

module Locotimezone
  class Locotime
    attr_reader :skip, :address
    attr_accessor :location

    def initialize(address:, location:, skip:)
      @location = location
      @address = address
      @skip = location ? :location : skip
    end

    def call
      validate_options
      location_data = geolocate unless skip == :location
      timezone_data = timezone unless skip == :timezone
      build_hash(location_data, timezone_data)
    end

    private

    def validate_options
      raise InvalidOptionsError if options_invalid?
    end

    def options_invalid?
      address.nil? && (skip == :timezone || skip.nil?)
    end

    def geolocate
      results = Geolocate.new(address).call
      self.location = results[:location] || {}
      results
    end

    def timezone
      Timezone.new(location).call
    end

    def build_hash(location_data, timezone_data)
      data = Hash.new
      data[:geo]      = location_data unless location_data.nil?
      data[:timezone] = timezone_data unless timezone_data.nil?
      data
    end
  end
end
