module ApiResponses
  BASE_PATH = %w[spec helpers api_responses].freeze
  def valid_geolocation_response
    path = File.join(*BASE_PATH, 'valid_geolocation_response.json')
    File.read(path, &:read)
  end
end
