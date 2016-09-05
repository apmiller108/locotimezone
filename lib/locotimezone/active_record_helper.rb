module Locotimezone
  module ActiveRecordHelper

   def locotime(options = {})
     data = Locotimezone.locotime(options)
     geolocation_attributes data[:geo] unless data[:geo].nil?
     timezone_attribute data[:timezone] unless data[:timezone].nil?
   end

   def geolocation_attributes(geo_data)
     save_latitude geo_data[:location][:lat]
     save_longitude geo_data[:location][:lng]
   end

   def timezone_attribute(timezone_data)
     send("#{attributes[:timezone_id]}=", timezone_data[:timezone_id])
   end

   def save_latitude(lat)
     send("#{attributes[:latitude]}=", lat)
   end

   def save_longitude(lng)
     send("#{attributes[:longitude]}=", lng)
   end

   def attributes
     Locotimezone.configuration.attributes
   end
  end
end
