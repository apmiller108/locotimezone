require 'open-uri'
require 'json'
require 'pry'

class LocoTime
  attr_reader :location_only, :timezone_only, :address, :key
  attr_accessor :location

  def initialize(location_only:, timezone_only:, address:, location:, key:)
    @location_only = location_only
    @timezone_only = timezone_only
    @location      = location
    @address       = address
    @key           = key || ''
  end

  def transform
    validate_options
    location_data = get_location unless timezone_only 
    timezone_data = get_timezone unless location_only
    build_hash(location_data, timezone_data)
  end

  private

  def validate_options
    if address.nil? && !timezone_only
      raise ArgumentError, 
        'locotimezone: address is required unless timezone_only'
    elsif location.nil? && timezone_only
      raise ArgumentError, 
        'locotimezone: location is required when timezone_only'
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
