require 'test_helper'

class Record < Struct.new(:latitude, :longitude, :timezone_id)
  include Locotimezone::ActiveRecordHelper

  def save(options)
    locotime options
  end
end

class LocotimezoneActiveRecordHelperTest < Minitest::Test

  describe 'sets location and timezone attributes' do 
    set_configuration
    it 'sets latitude' do
      record = Record.new
      record.save({ address: address })

      refute_nil record.latitude
    end

    it 'sets longitude' do
      record = Record.new
      record.save({ address: address })

      refute_nil record.longitude
    end

    it 'sets timezone_id' do
      record = Record.new
      record.save({ address: address })

      refute_nil record.timezone_id
    end
  end

  describe 'sets location and skips timezone' do
    set_configuration
    it 'sets latitude' do
      record = Record.new
      record.save({ address: address, skip: :timezone })

      refute_nil record.latitude
    end

    it 'sets longitude' do
      record = Record.new
      record.save({ address: address, skip: :timezone })

      refute_nil record.longitude
    end

    it 'sets timezone_id' do
      record = Record.new
      record.save({ address: address, skip: :timezone })

      assert_nil record.timezone_id
    end

  end

  describe 'sets timezone based on coordinates' do
    set_configuration
    it 'sets latitude' do
      record = Record.new
      record.save({ location: lat_lng })

      assert_nil record.latitude
    end

    it 'sets longitude' do
      record = Record.new
      record.save({ location: lat_lng })

      assert_nil record.longitude
    end

    it 'sets timezone_id' do
      record = Record.new
      record.save({ location: lat_lng })

      refute_nil record.timezone_id
    end

  end
end
