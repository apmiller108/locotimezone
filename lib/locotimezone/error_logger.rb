require 'logger'

module Locotimezone
  class ErrorLogger
    def self.stdout_log_for(error, severity: :warn)
      logger = Logger.new(STDOUT)
      logger.send(severity, 'locotimezone') do
        'Unable to complete API request. Server responded '\
        "with: #{error.message}"
      end
    end
  end
end
