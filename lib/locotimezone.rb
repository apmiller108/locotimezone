require 'locotimezone/version'
require 'locotimezone/loco_time'

module Locotimezone

  def self.get_loco(address = '525 NW 1st Ave FL 33301', options = {})
    lt = LocoTime.new address, options
    lt.run_query
  end

end
