module SpecHelpers
  def json
    JSON.parse(response.body)
  end

  def success_response
    JSON.parse(response.body)['body']
  rescue StandardError
    {}
  end
end
