require 'test_helper'

class LocotimezoneErrorsTest < Minitest::Test

  def setup
    set_configuration
  end

  describe 'testing error handling' do
    it 'must be empty if getting location returns bad request' do
      result = Locotimezone.locotime address: ''
      assert_empty result[:geo]
      assert_empty result[:timezone]
    end

    it 'must be empty if no location if found' do
      result = Locotimezone.locotime address: '%'
      assert_empty result[:geo]
      assert_empty result[:timezone]
    end

    it 'must return a geo hash even if address is not a string' do
      data_types = [[], {}, 0.1, 1, :a, 0..1, true]
      data_types.each do |data|
        result = Locotimezone.locotime address: data
        assert result[:geo]
      end
    end

    it 'must be empty if location is not a hash' do
      data_types = [[], 0.1, 1, 'a', :a, 0..1, true]
      data_types.each do |data|
        result = Locotimezone.locotime location: data
        assert_empty result[:timezone]
      end
    end

    it 'must be empty if getting timezone returns bad request' do
      result = Locotimezone.locotime location: { lat: 'bob', lng: 'loblaw' }
      assert_empty result[:timezone]
    end

    it 'must be empty if timezone cannot be found' do
      result = Locotimezone.locotime location: { lat: 0, lng: 0 }
      assert_empty result[:timezone]
    end

    it 'raises argument error if neither address not location is given' do
      assert_raises(ArgumentError) { Locotimezone.locotime }
    end

    it 'raises argument error if location is falsey' do
      assert_raises(ArgumentError) { Locotimezone.locotime location: nil }
      assert_raises(ArgumentError) { Locotimezone.locotime location: false }
    end

  end
end
