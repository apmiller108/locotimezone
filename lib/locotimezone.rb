require 'locotimezone/version'
require 'locotimezone/locotime'
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
    set_default_configuration if configuration.nil?
    Locotime.new(location: options.fetch(:location, nil),
                 address: options.fetch(:address, nil),
                 skip: options.fetch(:skip, nil)).call
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration if block_given?
    self
  end

  def self.reset_configuration
    self.configuration = Configuration.new
  end

  def self.set_default_configuration
    Locotimezone.configure { |config| config.google_api_key = '' }
  end
end
