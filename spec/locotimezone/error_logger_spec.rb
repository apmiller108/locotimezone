require 'spec_helper'

describe Locotimezone::ErrorLogger do
  describe '.stdout_log_for' do
    let(:error) { ArgumentError.new 'An error has occured' }
    let(:logger) { Logger.new(STDOUT) }

    before :each do
      allow(logger).to receive(:error)
    end

    it 'instantiates a Logger object with STDOUT' do
      expect(Logger).to receive(:new).with(STDOUT).and_return(logger)
      described_class.stdout_log_for(error, severity: :error)
    end

    it 'calls the servity method for keyword argument' do
      allow(Logger).to receive(:new).and_return(logger)

      expect(logger).to receive(:info)
      described_class.stdout_log_for(error, severity: :info)
    end
  end
end
