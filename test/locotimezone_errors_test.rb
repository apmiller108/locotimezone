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
      result = Locotimezone.locotime location: '%', skip: :location
      assert true, result[:timezone].empty?
    end

    it 'must be empty if getting timezone returns bad request' do
      result = Locotimezone.locotime location: { lat: 'bob', lng: 'loblaw' }, 
        skip: :location
      assert true, result[:timezone].empty?
    end

    it 'raises argument error if no address is given' do
      assert_raises(ArgumentError) { Locotimezone.locotime }
    end

    it 'raises argument error if no location is given when timezone only' do
      assert_raises ArgumentError do 
        Locotimezone.locotime skip: :location
      end
    end

  end
end
