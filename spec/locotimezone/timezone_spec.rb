require 'spec_helper'
include ApiResponses

describe Locotimezone::Timezone do
  let(:valid_location) { { lat: 26.1288238, lng: -80.1449743 } }

  before :each do
    Locotimezone.configure { |config| config.google_api_key = '123' }
  end

  subject do
    described_class.new(valid_location).call
  end

  describe '#call' do
    context '200 response' do
      before :each do
        stub_request(:get, /maps\/api\/timezone/)
          .to_return(status: 200, body: valid_timezone_response)
      end

      it 'returns a hash' do
        expect(subject).to be_instance_of Hash
      end

      it 'returns timezone data' do
        expect(subject).to(
          eq(
            timezone_id: 'America/New_York',
            timezone_name: 'Eastern Daylight Time'
          )
        )
      end
    end

    context '400 response' do
      let(:logger) { Logger.new(STDOUT) }

      before :each do
        stub_request(:get, /maps\/api\/timezone/).to_return(status: 400)
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

    context 'invalid location' do
      subject do
        described_class.new('invalid').call
      end

      it 'returns an hash' do
        expect(subject).to be_instance_of Hash
      end

      it 'returns an empty hash' do
        expect(subject).to be_empty
      end
    end
  end
end
