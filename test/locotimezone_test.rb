require 'test_helper'

class LocotimezoneTest < Minitest::Test
  attr_reader :locotime
  attr_reader :just_location
  attr_reader :just_timezone

  def setup
    @locotime = Locotimezone.locotime address
    @just_location = Locotimezone.locotime address, loction_only: true
    @just_timezone = Locotimezone.locotime address, timezone_only: true
  end

  def test_that_it_has_a_version_number
    refute_nil ::Locotimezone::VERSION
  end

  def test_that_it_has_correct_formatted_address
    assert_equal '525 NW 1st Ave, Fort Lauderdale, FL 33301, USA', 
      locotime[:formatted_address]
  end

  def test_that_it_has_correct_geolocation
    assert_equal 26.1288238, locotime[:location]['lat']
    assert_equal -80.1449743, locotime[:location]['lng']
  end

  def test_that_it_has_correct_timezone_id
    assert_equal 'America/New_York', locotime[:timezone]['timeZoneId']
  end

  def test_that_it_only_returns_location
    refute_nil just_location[:location]
    assert_nil just_location[:timezone]
  end

  def test_that_it_only_returns_timezone
    assert_nil just_location[:location]
    refute_nil just_location[:timezone]
  end
end
