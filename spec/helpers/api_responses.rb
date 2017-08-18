module ApiResponses
  BASE_PATH = %w[spec helpers api_responses].freeze

  def valid_geolocation_response
    read_file File.join(*BASE_PATH, 'valid_geolocation_response.json')
  end

  def valid_timezone_response
    read_file File.join(*BASE_PATH, 'valid_timezone_response.json')
  end

  private

  def read_file(path)
    File.read(path, &:read)
  end
end
