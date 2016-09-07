require 'test_helper'

class LocotimezoneConfigurationTest < Minitest::Test
  
  describe 'testing configuration' do
    it 'can be configured with an API key' do
      Locotimezone.reset_configuration
      Locotimezone.configure do |config|
        config.google_api_key = 'google api key'
      end

      assert_equal 'google api key', Locotimezone.configuration.google_api_key
    end

    it 'can reset configuration' do
      Locotimezone.configure do |config|
        config.google_api_key = 'a fake key to be reset'
        config.attributes = { latitude: :lat, longitude: :lng, timezone_id: :tid }
      end
      Locotimezone.reset_configuration
      default_attributes = { 
        latitude: :latitude, 
        longitude: :longitude, 
        timezone_id: :timezone_id 
      }

      assert_nil Locotimezone.configuration.google_api_key
      assert_equal default_attributes, Locotimezone.configuration.attributes

      set_configuration
    end

    it 'has default attribute names: latitude, longitude and timezone_id' do
      Locotimezone.reset_configuration
      Locotimezone.configure do |config|
        config.google_api_key = 'google api key'
      end
      expected_hash = { 
        latitude: :latitude, 
        longitude: :longitude, 
        timezone_id: :timezone_id 
      }

      assert_equal expected_hash, Locotimezone.configuration.attributes
    end

    it 'can override the default latitude  attribute' do
      Locotimezone.reset_configuration
      Locotimezone.configure do |config|
        config.google_api_key = 'google api key' 
        config.attributes = { latitude: :lat }
      end
      expected_hash = { 
        latitude: :lat, 
        longitude: :longitude, 
        timezone_id: :timezone_id 
      }

      assert_equal expected_hash, Locotimezone.configuration.attributes

      set_configuration
    end

    it 'can override the default longitude attribute' do
      Locotimezone.reset_configuration
      Locotimezone.configure do |config|
        config.google_api_key = 'google api key' 
        config.attributes = { longitude: :lng }
      end
      expected_hash = { 
        latitude: :latitude, 
        longitude: :lng, 
        timezone_id: :timezone_id 
      }

      assert_equal expected_hash, Locotimezone.configuration.attributes

      set_configuration
    end

    it 'can override the default timezone_id  attribute' do
      Locotimezone.reset_configuration
      Locotimezone.configure do |config|
        config.google_api_key = 'google api key' 
        config.attributes = { timezone_id: :tz_id }
      end
      expected_hash = { 
        latitude: :latitude, 
        longitude: :longitude, 
        timezone_id: :tz_id 
      }

      assert_equal expected_hash, Locotimezone.configuration.attributes

      set_configuration
    end
  end
end
