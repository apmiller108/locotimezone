require 'spec_helper'
require 'active_record'
include ApiResponses

describe Locotimezone::ActiveRecordHelper do
  before(:all) { ActiveRecord::Migration.verbose = false }
  before :each do
    ActiveRecord::Base.establish_connection adapter: 'sqlite3',
                                            database: 'memory'

    ApplicationRecord = Class.new(ActiveRecord::Base) do
      self.abstract_class = true
    end

    User = Class.new(ApplicationRecord) do
      include Locotimezone::ActiveRecordHelper
      after_validation lambda {
        locotime address: '525 NW 1st Ave, Fort Lauderdale, FL 33301'
      }
    end

    stub_request(:get, /maps\/api\/geocode/)
      .to_return(status: 200, body: valid_geolocation_response)
    stub_request(:get, /maps\/api\/timezone/)
      .to_return(status: 200, body: valid_timezone_response)
  end

  after :each do
    Object.send(:remove_const, :User)
    Object.send(:remove_const, :ApplicationRecord)
  end

  context 'with default attribute names' do
    before :each do
      ActiveRecord::Schema.define do
        create_table :users, force: true do |t|
          t.string :latitude
          t.string :longitude
          t.string :timezone_id
        end
      end
      User.create
    end

    let(:user) { User.take }

    it 'persists the latitude' do
      expect(user.latitude).to eq '26.1288237'
    end

    it 'persists the longitude' do
      expect(user.longitude).to eq '-80.144976'
    end

    it 'persists the timezone data' do
      expect(user.timezone_id).to eq 'America/New_York'
    end
  end

  context 'with overridden attribute names' do
    before :each do
      ActiveRecord::Schema.define do
        create_table :users, force: true do |t|
          t.string :lat
          t.string :lng
          t.string :tz_id
        end
      end

      Locotimezone.configure do |config|
        config.attributes = {
          latitude: :lat,
          longitude: :lng,
          timezone_id: :tz_id
        }
      end
      User.create
    end

    after(:each) { Locotimezone.reset_configuration }

    let(:user) { User.take }

    it 'persists the latitude' do
      expect(user.lat).to eq '26.1288237'
    end

    it 'persists the longitude' do
      expect(user.lng).to eq '-80.144976'
    end

    it 'persists the timezone data' do
      expect(user.tz_id).to eq 'America/New_York'
    end
  end

  context 'when configured with invalid attribute names' do
    before :each do
      ActiveRecord::Schema.define do
        create_table :users, force: true do |t|
          t.string :latitude
          t.string :longitude
          t.string :timezone_id
        end
      end

      Locotimezone.configure do |config|
        config.attributes = {
          latitude: :lat,
          longitude: :lng,
          timezone_id: :tz_id
        }
      end
    end

    after(:each) { Locotimezone.reset_configuration }

    it 'will not raise UnknownAttributeError' do
      expect { User.create }.to_not raise_error
    end

    it 'will not save the attributes' do
      user = User.create

      expect(user.latitude).to be nil
      expect(user.longitude).to be nil
      expect(user.timezone_id).to be nil
    end
  end

  context 'with empty geolocation and timezone results from 400 response' do
    let(:logger) { Logger.new STDOUT }

    before :each do
      ActiveRecord::Schema.define do
        create_table :users, force: true do |t|
          t.string :latitude
          t.string :longitude
          t.string :timezone_id
        end
      end
      stub_request(:get, /maps\/api\/geocode/).to_return(status: 400)
      stub_request(:get, /maps\/api\/timezone/).to_return(status: 400)
      allow(Logger).to receive(:new).and_return(logger)
      allow(logger).to receive(:error)
    end

    it 'does not raise error' do
      expect { User.create }.to_not raise_error
    end
  end

  context 'with valid location' do
    before :each do
      ActiveRecord::Schema.define do
        create_table :users, force: true do |t|
          t.string :latitude
          t.string :longitude
          t.string :timezone_id
        end
      end

      Object.send(:remove_const, :User)
      User = Class.new(ApplicationRecord) do
        include Locotimezone::ActiveRecordHelper
        after_validation lambda {
          locotime location: { lat: 26.1288238, lng: -80.1449743 }
        }
      end

      stub_request(:get, /maps\/api\/timezone/)
        .to_return(status: 200, body: valid_timezone_response)

      User.create
    end

    let(:user) { User.take }

    it 'persists the timezone_id' do
      expect(user.timezone_id).to eq 'America/New_York'
    end

    it 'does not persist the latitude' do
      expect(user.latitude).to be nil
    end

    it 'does not persist the longitude' do
      expect(user.longitude).to be nil
    end
  end

  context 'with skipping timezone option enabled' do
    before :each do
      ActiveRecord::Schema.define do
        create_table :users, force: true do |t|
          t.string :latitude
          t.string :longitude
          t.string :timezone_id
        end
      end

      Object.send(:remove_const, :User)
      User = Class.new(ApplicationRecord) do
        include Locotimezone::ActiveRecordHelper
        after_validation lambda {
          locotime address: '525 NW 1st Ave, Fort Lauderdale, FL 33301',
                   skip: :timezone
        }
      end

      stub_request(:get, /maps\/api\/geocode/)
        .to_return(status: 200, body: valid_geolocation_response)

      User.create(timezone_id: 'America/Los_Angeles')
    end

    let(:user) { User.take }

    it 'does not overwrite the timezone_id' do
      expect(user.timezone_id).to eq 'America/Los_Angeles'
    end

    it 'persists the latitude' do
      expect(user.latitude).to eq '26.1288237'
    end

    it 'persists the longitude' do
      expect(user.longitude).to eq '-80.144976'
    end
  end
end
