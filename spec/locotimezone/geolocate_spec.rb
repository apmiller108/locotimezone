require 'spec_helper'
include ApiResponses

describe Locotimezone::Geolocate do
  describe '#call' do
    let(:valid_address) { '525 NW 1st Ave, Fort Lauderdale, FL 33324' }

    before :each do
      Locotimezone.configure { |config| config.google_api_key = '123' }
    end

    subject do
      described_class.new(valid_address).call
    end

    context '200 response' do
      before :each do
        stub_request(:get, /maps\/api\/geocode/)
          .to_return(status: 200, body: valid_geolocation_response)
      end

      it 'returns a hash' do
        expect(subject).to be_instance_of Hash
      end

      it 'returns geolocation data' do
        expect(subject).to(
          eq(
            location: {
              lat: 26.1288237,
              lng: -80.144976
            },
            formatted_address: '525 NW 1st Ave, Fort Lauderdale, FL 33301, USA'
          )
        )
      end
    end

    context '400 response' do
      let(:logger) { Logger.new(STDOUT) }

      before :each do
        stub_request(:get, /maps\/api\/geocode/).to_return(status: 400)
        allow(Logger).to receive(:new).and_return(logger)
        allow(logger).to receive(:error)
      end

      it 'returns a hash' do
        expect(subject).to be_instance_of Hash
      end

      it 'returns an empty hash' do
        expect(subject).to be_empty
      end
    end
  end
end
