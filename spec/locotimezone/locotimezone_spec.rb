require 'spec_helper'
include ApiResponses

describe Locotimezone do
  let(:valid_address) { '525 NW 1st Ave, Fort Lauderdale, FL 33324' }
  let(:valid_location) { { lat: 26.1288238, lng: -80.1449743 } }

  before :each do
    stub_request(:get, /maps\/api\/geocode/)
      .to_return(body: valid_geolocation_response)
    stub_request(:get, /maps\/api\/timezone/)
      .to_return(body: valid_timezone_response)
  end

  describe '.locotime' do
    context 'with default configuration' do
      before :each do
        Locotimezone.configuration = nil
      end

      context 'with valid address' do
        subject do
          Locotimezone.locotime address: valid_address
        end

        it 'returns a hash' do
          expect(subject).to be_instance_of Hash
        end

        it 'returns the geolocation data' do
          expect(subject[:geo][:location]).to(
            eq(lat: 26.1288237, lng: -80.144976)
          )
        end

        it 'returns the formatted address' do
          expect(subject[:geo][:formatted_address]).to(
            eq('525 NW 1st Ave, Fort Lauderdale, FL 33301, USA')
          )
        end

        it 'returns a the timezone id' do
          expect(subject[:timezone][:timezone_id]).to eq 'America/New_York'
        end

        it 'returns the timezone name' do
          expect(subject[:timezone][:timezone_name]).to eq 'Eastern Daylight Time'
        end

        context 'with skip: :timezone option' do
          subject do
            Locotimezone.locotime address: valid_address, skip: :timezone
          end

          it 'returns the geolocation data' do
            expect(subject[:geo][:location]).to(
              eq(lat: 26.1288237, lng: -80.144976)
            )
          end

          it 'returns the formatted address' do
            expect(subject[:geo][:formatted_address]).to(
              eq('525 NW 1st Ave, Fort Lauderdale, FL 33301, USA')
            )
          end

          it 'does not return timezone data' do
            expect(subject[:timezone]).to be nil
          end
        end
      end

      context 'with valid location data' do
        subject do
          Locotimezone.locotime location: valid_location
        end

        it 'returns a the timezone id' do
          expect(subject[:timezone][:timezone_id]).to eq 'America/New_York'
        end

        it 'returns the timezone name' do
          expect(subject[:timezone][:timezone_name]).to eq 'Eastern Daylight Time'
        end

        it 'does not return geolocation data' do
          expect(subject[:geo]).to be nil
        end
      end

      context 'without address or location' do
        it 'raises an ArgumentError' do
          expect { Locotimezone.locotime }.to(
            raise_error(ArgumentError, 'locotimezone is missing address or location.')
          )
        end
      end

      context 'when location included and it is nil' do
        it 'raises an ArgumentError' do
          expect { Locotimezone.locotime }.to(
            raise_error(ArgumentError, 'locotimezone is missing address or location.')
          )
        end
      end
    end
  end
end
