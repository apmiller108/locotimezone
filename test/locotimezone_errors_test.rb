require 'test_helper'

class LocotimezoneErrorsTest < Minitest::Test

  describe 'testing error handling' do
    it 'must be empty if getting location returns bad request' do
      result = Locotimezone.locotime address: ''
      assert true, result[:geo].empty?
      assert true, result[:timezone].empty?
    end

    it 'must be empty if no location if found' do
      result = Locotimezone.locotime address: '%'
      assert true, result[:geo].empty?
      assert true, result[:timezone].empty?
    end

    it 'must be empty if location is not a hash' do
      data_types = [[], 0.1, 1, 'a', :a, 0..1, true]
      data_types.each do |data|
        result = Locotimezone.locotime location: data
        assert true, result[:timezone].empty?
      end
    end

    it 'must be empty if getting timezone returns bad request' do
      result = Locotimezone.locotime location: { lat: 'bob', lng: 'loblaw' }
      assert true, result[:timezone].empty?
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
