$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'locotimezone'

require 'minitest/autorun'

def address
  "525 NW 1st Ave Fort Lauderdale, FL 33301"
end

def lat_lng
  { lat: '26.1288238', lng: '-80.1449743' }
end
