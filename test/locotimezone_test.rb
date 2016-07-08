require 'test_helper'

class LocotimezoneTest < Minitest::Test
  attr_reader :loco

  def test_that_it_has_a_version_number
    refute_nil ::Locotimezone::VERSION
  end

  def setup
    @loco = Locotimezone.locotime address
  end

  def test_that_it_has_correct_formatted_address
    assert_equal '525 NW 1st Ave, Fort Lauderdale, FL 33301, USA', 
      loco[:formatted_address]
  end

  def test_that_it_has_correct_geolocation
    assert_equal 26.1288238, loco[:location]['lat']
    assert_equal -80.1449743, loco[:location]['lng']
  end

  def test_that_it_has_correct_timezone_id
    assert_equal 'America/New_York', loco[:timezone]['timeZoneId']
  end
end
