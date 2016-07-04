require 'locotimezone/version'
require 'locotimezone/loco_time'
require 'locotimezone/loco'
require 'locotimezone/timezone'

module Locotimezone

  def self.get_loco(address = '525 NW 1st Ave FL 33301', options = {})
    LocoTime.new(address, options).transform_location
  end

end
