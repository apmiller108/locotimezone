require 'test_helper'

class LocotimezoneTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Locotimezone::VERSION
  end

  def test_that_it_has_correct_formatted_address
    stub_any_instance(Locotimezone::Geolocate, :get_geo, get_geo_results) do
      stub_any_instance(Locotimezone::Timezone, 
                        :timezone, 
                        get_timezone_results) do
        result = Locotimezone.locotime address: address

        assert_equal('525 NW 1st Ave, Fort Lauderdale, FL 33301, USA', 
                     result[:geo][:formatted_address])
      end
    end
  end

  def test_that_it_has_correct_geolocation
    stub_any_instance(Locotimezone::Geolocate, :get_geo, get_geo_results) do
      stub_any_instance(Locotimezone::Timezone, 
                        :timezone, 
                        get_timezone_results) do
        result = Locotimezone.locotime address: address

        assert_equal 26.1288238, result[:geo][:location][:lat]
        assert_equal -80.1449743, result[:geo][:location][:lng]
      end
    end
  end

  def test_that_it_has_correct_timezone_id
    stub_any_instance(Locotimezone::Geolocate, :get_geo, get_geo_results) do
      stub_any_instance(Locotimezone::Timezone, 
                        :timezone, 
                        get_timezone_results) do
        result = Locotimezone.locotime address: address

        assert_equal 'America/New_York', result[:timezone][:timezone_id]
      end
    end
  end

  def test_that_it_only_returns_location
    stub_any_instance(Locotimezone::Geolocate, :get_geo, get_geo_results) do
      stub_any_instance(Locotimezone::Timezone, 
                        :timezone, 
                        get_timezone_results) do
        result = Locotimezone.locotime address: address, skip: :timezone

        refute_nil result[:geo]
        assert_nil result[:timezone]
      end
    end
  end

  def test_that_it_only_returns_timezone
    stub_any_instance(Locotimezone::Geolocate, :get_geo, get_geo_results) do
      stub_any_instance(Locotimezone::Timezone, 
                        :timezone, 
                        get_timezone_results) do
        result = Locotimezone.locotime location: location

        assert_nil result[:geo]
        refute_nil result[:timezone]
      end
    end
  end

  def test_that_it_is_empty_if_bad_request
    error = Class.new(OpenURI::HTTPError)
    File.stub :open, error do
      result = Locotimezone.locotime address: 'bad stuff'

      assert true, result[:geo].empty?
      assert true, result[:timezone].empty?
    end
  end

  def test_that_it_is_empty_if_no_location_found
    empty_response = { 'results' => {} }
    stub_any_instance Locotimezone::Geolocate, :get_geo, empty_response do
      result = Locotimezone.locotime address: 'fake address'

      assert true, result[:geo].empty?
      assert true, result[:timezone].empty?
    end
  end
end
