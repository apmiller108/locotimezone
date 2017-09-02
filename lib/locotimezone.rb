require 'locotimezone/version'
require 'locotimezone/locotime'
require 'locotimezone/geolocate'
require 'locotimezone/timezone'
require 'locotimezone/errors'
require 'locotimezone/error_logger'
require 'locotimezone/configuration'
require 'locotimezone/results_formatter'
require 'locotimezone/active_record_helper'
require 'locotimezone/railtie' if defined?(Rails)

module Locotimezone
  class << self
    attr_accessor :configuration
  end

  def self.locotime(options = {})
    configure_with_defaults if configuration.nil?
    Locotime.new(location: options[:location],
                 address: options[:address],
                 skip: options[:skip]).call
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration if block_given?
    self
  end

  def self.reset_configuration
    self.configuration = Configuration.new
    configure_with_defaults
  end

  def self.configure_with_defaults
    Locotimezone.configure { |config| config.google_api_key = '' }
  end
end
