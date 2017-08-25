module Locotimezone
  class Configuration
    attr_accessor :google_api_key
    attr_reader :attributes

    def initialize
      @attributes = {
        latitude: :latitude,
        longitude: :longitude,
        timezone_id: :timezone_id
      }
    end

    def attributes=(value)
      return unless value.respond_to? :has_key
      @attributes = attributes.merge value
    end
  end
end
