require 'test_helper'

class LocotimezoneErrorsTest < Minitest::Test

  describe 'testing error handling' do
    it 'must be empty if bad request' do
      result = Locotimezone.locotime address: ''
      assert true, result[:geo].empty?
      assert true, result[:timezone].empty?
    end

    it 'must be empty if no location is found' do
      result = Locotimezone.locotime address: '%'
      assert true, result[:geo].empty?
      assert true, result[:timezone].empty?
    end

    it 'raises argument error if no address is given' do
      assert_raises(ArgumentError) { Locotimezone.locotime }
    end

    it 'raises argument error if no location is given when timezone only' do
      assert_raises ArgumentError do 
        Locotimezone.locotime timezone_only: true 
      end
    end

  end
end
