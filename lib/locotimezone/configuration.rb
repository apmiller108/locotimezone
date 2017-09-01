module Locotimezone
  class Configuration
    attr_accessor :google_api_key
    attr_reader :attributes

    def initialize
      @attributes = default_attributes
    end

    def attributes=(value)
      return unless value.respond_to? :has_key?
      @attributes = attributes.merge value
    end

    def attr_writers
      attributes.each_with_object({}) do |(key, value), hash|
        hash[key] = "#{value}="
      end
    end

    private

    def default_attributes
      {
        latitude: :latitude,
        longitude: :longitude,
        timezone_id: :timezone_id
      }
    end
  end
end
