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
    self.class.get("/manga/#{manga_id}/feed", @options)
  end

  private

  def handle_response(response)
    if response.success?
      response
    else
      # Log the error or raise an exception
      Rails.logger.error("MangaDex API request failed: #{response.body}")
      {} # or [] if you prefer
    end
  end
  
end
