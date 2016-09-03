$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'locotimezone'

require 'minitest/autorun'

def address
  "525 NW 1st Ave Fort Lauderdale, FL 33301"
end

def lat_lng
  { lat: '26.1288238', lng: '-80.1449743' }
end

def set_configuration
  Locotimezone.configure do |config| 
    config.google_api_key = ENV['GOOGLE_API_KEY']
  end
end

def full_results
  { 
    :geo => { 
      :formatted_address => "525 NW 1st Ave, Fort Lauderdale, FL 33301, USA", 
      :location => { :lat => 26.1288238, :lng => -80.1449743 } 
    },
    :timezone => { 
      :timezone_id => "America/New_York", 
      :timezone_name => "Eastern Daylight Time" 
    }
  }
end

def location_results
  { 
    :geo => { 
      :formatted_address => "525 NW 1st Ave, Fort Lauderdale, FL 33301, USA", 
      :location => { :lat => 26.1288238, :lng => -80.1449743 } 
    }
  }
end

def timezone_results
  { 
    :timezone => { 
      :timezone_id => "America/New_York", 
      :timezone_name => "Eastern Daylight Time" 
    }
  }
end
