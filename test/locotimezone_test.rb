require 'test_helper'

class LocotimezoneTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Locotimezone::VERSION
  end

  def test_that_it_has_location
    loco = Locotimezone::LocoTime.new address: address
    refute_nil loco.location
  end
end
