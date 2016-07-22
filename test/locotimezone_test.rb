require 'test_helper'

class LocotimezoneTest < Minitest::Test
  
  class << self
    attr_accessor :locotime, :just_location, :just_timezone
  end

  def setup
    LocotimezoneTest.locotime = LocotimezoneTest.locotime || 
      Locotimezone.locotime(address: address)
    LocotimezoneTest.just_location = LocotimezoneTest.just_location || 
      Locotimezone.locotime(address: address, location_only: true)
    LocotimezoneTest.just_timezone = LocotimezoneTest.just_timezone || 
      Locotimezone.locotime(location: lat_lng, timezone_only: true)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Locotimezone::VERSION
  end

  def test_that_it_has_correct_formatted_address
    assert_equal '525 NW 1st Ave, Fort Lauderdale, FL 33301, USA', 
      self.class.locotime[:geo][:formatted_address]
  end

  def test_that_it_has_correct_geolocation
    assert_equal 26.1288238, self.class.locotime[:geo][:location][:lat]
    assert_equal -80.1449743, self.class.locotime[:geo][:location][:lng]
  end

  def test_that_it_has_correct_timezone_id
    assert_equal 'America/New_York', self.class.locotime[:timezone][:timezone_id]
  end

  def test_that_it_only_returns_location
    refute_nil self.class.just_location[:geo]
    assert_nil self.class.just_location[:timezone]
  end

  def test_that_it_only_returns_timezone
    assert_nil self.class.just_timezone[:geo]
    refute_nil self.class.just_timezone[:timezone]
  end

  def test_that_it_is_empty_if_bad_request
    result = Locotimezone.locotime address: ''
    assert true, result[:geo].empty?
    assert true, result[:timezone].empty?
  end
end
