require 'test_helper'

class LocotimezoneConfigurationTest < Minitest::Test
  
  describe 'testing configuration' do
    it 'can be configured with an API key' do
      Locotimezone.configure do |config|
        config.key = 'google api key'
      end

      assert_equal 'google api key', Locotimezone.configuration.key
    end

    it 'can reset configuration' do
      Locotimezone.configure do |config|
        config.key = 'a fake key to be reset'
      end

      Locotimezone.reset_configuration

      assert_nil Locotimezone.configuration.key
    end
  end
end
