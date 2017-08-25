module Locotimezone
  module ActiveRecordHelper
    def locotime(options = {})
      data = Locotimezone.locotime(options)
      geolocation_attributes data[:geo] unless data[:geo].nil?
      timezone_attribute data[:timezone] unless data[:timezone].nil?
    end

    def geolocation_attributes(geolocation_data)
      return nil if geolocation_data.empty?
      geolocation_data[:location].each do |key, value|
        attribute = :latitude
        attribute = :longitude if key == :lng
        save_attribute(attribute, value)
      end
    end

    def timezone_attribute(timezone_data)
      return nil if timezone_data.empty?
      save_attribute(:timezone_id, timezone_data[:timezone_id])
    end

    def save_attribute(attribute, value)
      if respond_to? attr_writers[attribute]
        send attr_writers[attribute], value
      end
    end

    def attr_writers
      Locotimezone.configuration.attributes.each_with_object({}) do |(key, value), hash|
        hash[key] = "#{value}="
      end
    end
  end
end
