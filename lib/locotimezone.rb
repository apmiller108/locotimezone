require "locotimezone/version"

module Locotimezone
  class LocoTime
    attr_reader :location
    def initialize(options = {})
      @address  = options.fetch(:address)
      @key      = options.fetch(:key, ENV['GOOGLE_API_KEY'])
      @location = get_location
    end

    private

    def get_location

    end

  end
end
