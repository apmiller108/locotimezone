require 'locotimezone/version'
require 'locotimezone/loco_time'
require 'locotimezone/location'
require 'locotimezone/timezone'

module Locotimezone

  def self.locotime(options = {})
    location_only = options.fetch(:location_only, false)
    timezone_only = options.fetch(:timezone_only, false)
    location      = options.fetch(:location, nil)
    address       = options.fetch(:address, nil)
    key           = options.fetch(:key, ENV['GOOGLE_API_KEY'])

    LocoTime.new(
      location_only: location_only,
      timezone_only: timezone_only, 
      location: location,
      address: address, 
      key: key
    ).transform
  end

end
