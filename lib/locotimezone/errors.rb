module Locotimezone
  class LocoError < StandardError; end

  class InvalidOptionsError < LocoError
    def initialize(message = 'address or location is required')
      super(message)
    end
  end
end
