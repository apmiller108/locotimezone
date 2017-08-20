require 'spec_helper'

describe 'Configuring Locotimezone' do
  let :default_attributes do
    {
      latitude: :latitude,
      longitude: :longitude,
      timezone_id: :timezone_id
    }
  end

  subject do
    Locotimezone
  end

  before :each do
    subject.reset_configuration
    subject.configure { |config| config.google_api_key = '123' }
  end

  it 'configures with an API key' do
    expect(subject.configuration.google_api_key).to eq '123'
  end

  it 'sets default data model attributes' do
    expect(subject.configuration.attributes).to eq default_attributes
  end

  describe 'overriding default attributes' do
    before :each do
      subject.configure do |config|
        config.attributes = {
          latitude: :lat,
          longitude: :lng,
          timezone_id: :tid
        }
      end
    end

    it 'overrides the latitude default' do
      expect(subject.configuration.attributes[:latitude]).to eq :lat
    end

    it 'overrides the longitude default' do
      expect(subject.configuration.attributes[:longitude]).to eq :lng
    end

    it 'overrides the timezone default' do
      expect(subject.configuration.attributes[:timezone_id]).to eq :tid
    end
  end

  describe 'resetting the configuration' do
    before :each do
      subject.configure do |config|
        config.google_api_key = '123'
        config.attributes = {
          latitude: :lat,
          longitude: :lng,
          timezone_id: :tid
        }
      end
      subject.reset_configuration
    end

    it 'clears the API key' do
      expect(subject.configuration.google_api_key).to eq ''
    end

    it 'resets the attributes back to the defaults' do
      expect(subject.configuration.attributes).to eq default_attributes
    end
  end
end
