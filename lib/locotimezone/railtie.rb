require 'rails'
require 'locotimezone/active_record_helper'

module Locotimezone
  class Railtie < Rails::Railtie
    initializer 'locotimezone.active_record_helper' do
      ActiveSupport.on_load(:active_record) do
        include Locotimezone::ActiveRecordHelper
      end
    end
  end
end
