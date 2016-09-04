require 'test_helper'

class LocotimezoneConfigurationTest < Minitest::Test
  
  describe 'testing configuration' do
    it 'can be configured with an API key' do
      Locotimezone.configure do |config|
        config.google_api_key = 'google api key'
      end

      assert_equal 'google api key', Locotimezone.configuration.google_api_key
    end

    it 'can reset configuration' do
      Locotimezone.configure do |config|
        config.google_api_key = 'a fake key to be reset'
      end

      Locotimezone.reset_configuration

      assert_nil Locotimezone.configuration.google_api_key

      set_configuration
    end
  end
end
