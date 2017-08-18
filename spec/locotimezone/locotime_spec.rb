require 'spec_helper'
include ApiResponses

describe '.locotime' do
  subject do
    Locotimezone
  end

  let(:valid_address) { '525 NW 1st Ave, Fort Lauderdale, FL 33324' }

  before :each do
    stub_request(:get, /maps\.googleapis/).to_return(body: valid_geolocation_response)
  end

  context 'with default configuration' do
    before :each do
      subject.configuration = nil
    end

    context 'with valid address' do
      it 'returns a hash of geolocation and timezone data' do
        subject.locotime address: valid_address
      end
    end
  end
end
