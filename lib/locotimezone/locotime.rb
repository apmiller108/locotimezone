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
      ResultsFormatter.build_hash_for(geolocation, timezone)
    end

    private

    def validate_options
      raise InvalidOptionsError if options_invalid?
    end

    def options_invalid?
      address.nil? && (skip == :timezone || skip.nil?)
    end

    def geolocation
      return if skip == :location
      results = Geolocate.new(address).call
      @location = results[:location] || {}
      results
    end

    def timezone
      return if skip == :timezone
      Timezone.new(location).call
    end
  end
end
