class MangaDexService
  include HTTParty
  base_uri ENV['BASE_URI']

  #def auth
  #  @token = self.class.post('https://auth.mangadex.org/realms/mangadex/protocol/openid-connect/token',
  #                           body: "grant_type=password&username=kajijangching@gmail.com&password=password&client_id=personal-client-bd1da4a1-e5b7-4ddd-82d1-fb73c9c6bce5-b317be28&client_secret=NigfmmZsMBTt7WK1mZWc9SdeRkgFhZMz",
  #                           headers: { 'Content-Type': "application/x-www-form-urlencoded" }
  #                          )
  #end

  def initialize
    @options = { headers: { 'Content-Type' => 'application/json' } }
  end

  def get_manga_list
    self.class.get('/manga', @options)
  end

  def get_manga(id)
    self.class.get("/manga/#{id}", @options)
  end

  def get_cover_art(manga)
    cover_art_id = manga['relationships'].find { |r| r['type'] == 'cover_art' }
    if cover_art_id
      response = self.class.get("/cover/#{cover_art_id['id']}", @options)
      cover_art_api = handle_response(response)
      if cover_art_api['data']
        cover_art_manga = cover_art_api['data']['relationships'].find { |r| r['type'] == 'manga' }
        cover_art_filename = cover_art_api['data']['attributes']['fileName']
        return "https://uploads.mangadex.org/covers/#{cover_art_manga['id']}/#{cover_art_filename}"
      end
    end
  end

  def get_chapters(manga_id)
    response = self.class.get("/manga/#{manga_id}/feed", @options)
    handle_response(response)
  end

  def get_chapter_pages(chapter_id)
    response = self.class.get("/at-home/server/#{chapter_id}", @options)
    chapter_page_api = handle_response(response)
    chapter_pages = {}
    chapter_page_api['chapter']['dataSaver'].each_with_index do |file_name, index|
      chapter_pages[index] = "https://uploads.mangadex.org/data-saver/#{chapter_page_api['chapter']['hash']}/#{file_name}"
    end
    return chapter_pages
    puts "chapter pages: ", chapter_pages
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
