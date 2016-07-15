require 'locotimezone/version'
require 'locotimezone/loco_time'
require 'locotimezone/location'
require 'locotimezone/timezone'

module Locotimezone

  def self.locotime(options = {})
    location_only = options.fetch(:location_only, false)
    timezone_only = options.fetch(:timezone_only, false)
    address       = options.fetch(:address, '525 NW 1st Ave FL 33301')
    location      = options.fetch(:location, { lat: '26.1288238', lng: '-80.1449743' })
    secure        = options.fetch(:secure, true)
    key           = options.fetch(:key, ENV['GOOGLE_API_KEY'])

    LocoTime.new(
      address: address, 
      location_only: location_only,
      timezone_only: timezone_only, 
      secure: secure, 
      key: key,
      location: location
    ).transform
  end

end
