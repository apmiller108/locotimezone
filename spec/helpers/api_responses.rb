module ApiResponses
  BASE_PATH = %w[spec helpers api_responses].freeze
  RESPONSE_TYPES = %w[valid_geolocation valid_timezone]

  def self.define_responses
    RESPONSE_TYPES.each do |response_type|
      define_method("#{response_type}_response") do
        File.read(File.join(*BASE_PATH, "#{response_type}_response.json"), &:read)
      end
    end
  end

  define_responses
end
