require 'json'

class LocoTime
  def initialize(address, options = {})
    @address  = address
    @key      = options.fetch(:key, ENV['GOOGLE_API_KEY'])
  end

  def transform_location
    Hash[
      formatted_address: get_location['formatted_address'],
      location: get_location['geometry']['location'],
      timezone: get_timezone
    ]
  end

  private

  def get_location
    return @location if defined? @location
    @location = Loco.new(@address, @key).geolocate
  end

  def get_timezone
    return @timezone if defined? @timezone
    @timezone = Timezone.new(@location, @key).timezone
  end

end
