require 'locotimezone/version'
require 'locotimezone/loco_time'
require 'locotimezone/location'
require 'locotimezone/timezone'

module Locotimezone

  def self.locotime(options = {})
    LocoTime.new(
      location: options.fetch(:location, nil),
      address: options.fetch(:address, nil), 
      skip: options.fetch(:skip, nil),
      key: options.fetch(:key, ENV['GOOGLE_API_KEY'])
    ).transform
  end

end
