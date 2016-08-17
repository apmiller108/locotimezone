require 'locotimezone/version'
require 'locotimezone/loco_time'
require 'locotimezone/location'
require 'locotimezone/timezone'
require 'locotimezone/configuration'

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
  end

  def self.reset_configuration
    self.configuration = Configuration.new
  end

end
