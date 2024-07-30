class MangaDexService
  include HTTParty
  base_uri ENV['BASE_URI']

  def initialize
    @options = { headers: { 'Content-Type' => 'application/json' } }
  end

  def get_manga_list
    self.class.get('/manga', @options)
  end

  def get_manga(id)
    self.class.get("/manga/#{id}", @options)
  end

  def get_chapters(manga_id)
    response = self.class.get("/chapter?manga=#{manga_id}", @options)
    handle_response(response)
  end

  private

  def handle_response(response)
    if response.success?
      response.parsed_response
    else   # Log the error or raise an exception
      Rails.logger.error("MangaDex API request failed: #{response.body}")
      {}
    end
  end
  
end
