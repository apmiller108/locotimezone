module Locotimezone
  module ActiveRecordHelper
    def locotime(options = {})
      data = Locotimezone.locotime(options)
      attr_writers = Locotimezone.configuration.attr_writers

      unless data[:geo].nil? || data[:geo].empty?
        data[:geo][:location].each do |key, value|
          attr_key = (key == :lat ? :latitude : :longitude)

          next unless respond_to?(attr_writers[attr_key])
          send(attr_writers[attr_key], value)
        end
      end

      unless data[:timezone].nil? || data[:timezone].empty?
        tz_writer = attr_writers[:timezone_id]
        send(tz_writer, data[:timezone][:timezone_id]) if respond_to?(tz_writer)
      end
    end
  end
end
