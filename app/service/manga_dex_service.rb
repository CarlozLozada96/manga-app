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
    get_request("/manga")
  end

  def get_manga(id)
    get_request("/manga/#{id}")
  end

  def get_cover_art(manga)
    cover_art_id = manga['relationships'].find { |r| r['type'] == 'cover_art' }&.dig('id')
    return "No cover art" unless cover_art_id
    
    cover_art_api = get_request("/cover/#{cover_art_id}")
    cover_art_manga = cover_art_api['data']['relationships'].find { |r| r['type'] == 'manga' }
    cover_art_filename = cover_art_api['data']['attributes']['fileName']
    return "https://uploads.mangadex.org/covers/#{cover_art_manga['id']}/#{cover_art_filename}"
  end

  def search_manga(title)
    get_request("/manga", query: { title: title })
  end

  def get_chapters(manga_id)
    get_request("/manga/#{manga_id}/feed")
  end

  def get_chapter_pages(chapter_id)
    chapter_page_api = get_request("/at-home/server/#{chapter_id}")
    chapter_pages = {}
    Rails.logger.debug("Chapter Pages Api: #{chapter_page_api.inspect} \n")
    if chapter_page_api != {}
      chapter_page_api['chapter']['dataSaver'].each_with_index do |file_name, index|
        chapter_pages[index] = "https://uploads.mangadex.org/data-saver/#{chapter_page_api['chapter']['hash']}/#{file_name}"
      end
      return chapter_pages
    else
      return "No pages available"
    end
  end

  private

  def get_request(path, options = {})
    response = self.class.get(path, @options.merge(options))
    if response.success?
      response.parsed_response
    else   # Log the error or raise an exception
      Rails.logger.error("MangaDex API request failed: #{response.body}")
      {}
    end
  end
  
end
