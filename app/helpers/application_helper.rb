require 'json'
require "httparty"

module ApplicationHelper

  def ocr_veryfi(url_photo)
    url = "https://api.veryfi.com/api/v8/partner/documents"
    headers = {
      "Content-Type" => 'application/json',
      "Accept" => 'application/json',
      "CLIENT-ID" => ENV['CLIENT_ID_VERYFI'],
      "AUTHORIZATION" => "apiKey #{ENV['API_KEY_VERYFI']}"
    }

    payload = {
      file_url: url_photo
    }.to_json

    response = HTTParty.post(url, headers: headers, body: payload)
    JSON.parse(response.body)
  end
end
