require 'test_helper'

class LocotimezoneTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Locotimezone::VERSION
  end

  def test_that_it_has_location
    loco = Locotimezone.locotime address
    refute_nil loco[:location]
  end

  def test_that_it_has_formatted_address
    loco = Locotimezone.locotime address
    refute_nil loco[:formatted_address]
  end

  def test_that_it_has_timezone_date
    loco = Locotimezone.locotime address
    refute_nil loco[:timezone]
  end
end
