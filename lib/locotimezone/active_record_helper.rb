module Locotimezone
  module ActiveRecordHelper
   def locotime(options = {})
     data = Locotimezone.locotime(options)
     self.latitude = data[:geo][:location][:lat]
     self.longitude = data[:geo][:location][:lng]
     self.timezone_id = data[:timezone][:timezone_id]
   end
  end
end
