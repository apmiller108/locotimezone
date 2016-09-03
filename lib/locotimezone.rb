require 'locotimezone/version'
require 'locotimezone/loco_time'
require 'locotimezone/geolocate'
require 'locotimezone/timezone'
require 'locotimezone/configuration'
require 'locotimezone/active_record_helper'
require 'locotimezone/railtie' if defined?(Rails)

module Locotimezone

  class << self
    attr_accessor :configuration
  end

  def self.locotime(options = {})
    LocoTime.new(
      location: options.fetch(:location, nil),
      address: options.fetch(:address, nil), 
      skip: options.fetch(:skip, nil)
    ).transform
  end

  def self.configure
    self.configuration ||= Configuration.new 
    yield configuration if block_given?
    self
  end

  def self.reset_configuration
    self.configuration = Configuration.new
  end

end
