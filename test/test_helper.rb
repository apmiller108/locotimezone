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
    config.google_api_key = 'fake_api_key'
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

def get_geo_results
  {
    :formatted_address => "525 NW 1st Ave, Fort Lauderdale, FL 33301, USA", 
    :location => { :lat => 26.1288238, :lng => -80.1449743 }
  }
end

def get_timezone_results
  {
    :timezone_id => "America/New_York", 
    :timezone_name => "Eastern Daylight Time"
  }
end

def stub_any_instance(klass, method, return_value)
  klass.class_eval do
    alias_method "original_#{method}".to_sym, method

    define_method(method) do
      if return_value.respond_to? :call
        return_value.call
      else
        return_value
      end
    end
  end

  yield

ensure

  klass.class_eval do
    undef_method method
    alias_method method, "original_#{method}".to_sym
    undef_method "original_#{method}".to_sym
  end
end
