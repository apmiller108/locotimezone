require 'open-uri'
require 'json'

class LocoTime
  attr_reader :address
  attr_reader :key

  def initialize(address:, location_only:, timezone_only:, insecure:, key:)
    @address  = address
    @key      = key
  end

  def transform
    Hash[
      formatted_address: get_location[:formatted_address],
      location: get_location[:location],
      timezone: get_timezone
    ]
  end

  private

  def get_location
    return @location if defined? @location
    @location = Location.new(address, key).geolocate
  end

  def get_timezone
    return @timezone if defined? @timezone
    @timezone = Timezone.new(@location, key).timezone
  end

end
