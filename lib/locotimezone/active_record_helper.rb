module Locotimezone
  module ActiveRecordHelper
   def locotime(options = {})
     data = Locotimezone.locotime(options)
     update_geo_attributes data[:geo] unless data[:geo].nil?
     update_timezone_attribute data[:timezone] unless data[:timezone].nil?
   end

   def update_geo_attributes(geo_data)
     self.latitude = geo_data[:location][:lat]
     self.longitude = geo_data[:location][:lng]
   end

   def update_timezone_attribute(timezone_data)
     self.timezone_id = timezone_data[:timezone_id]
   end
  end
end
