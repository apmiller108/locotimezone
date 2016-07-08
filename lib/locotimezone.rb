require 'locotimezone/version'
require 'locotimezone/loco_time'
require 'locotimezone/location'
require 'locotimezone/timezone'

module Locotimezone

  def self.locotime(address = '525 NW 1st Ave FL 33301', options = {})
    location_only = options.fetch(:location_only, false)
    timezone_only = options.fetch(:timezone_only, false)
    insecure      = options.fetch(:insecure, false)
    key           = options.fetch(:key, ENV['GOOGLE_API_KEY'])
    LocoTime.new(address: address, location_only: location_only,
                timezone_only: timezone_only, insecure: insecure, key: key)
      .transform
  end
end
