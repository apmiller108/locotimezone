require 'spec_helper'

describe Locotimezone do
  subject do
    described_class::VERSION
  end

  it 'has a version number' do
    expect(subject).to match(/\d\.\d\.\d/)
  end
end
