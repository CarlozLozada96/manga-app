require_relative '../service/api_service'

class MangaController < ApplicationController
  def index
    @manga_list = MangaDexService.new.get_manga_list
    Rails.logger.debug("Manga list: #{@manga_list.inspect} \n")

    @cover_art_urls = {}
    @manga_list['data'].each do |manga|
     # cover_art_relation = manga['relationships'].find { |r| r['type'] == 'cover_art' }
     # if cover_art_relation
     #   cover_art_api = MangaDexService.new.get_cover_art_url(cover_art_relation['id'])
     #   if cover_art_api['data']
     #     cover_art_manga = cover_art_api['data']['relationships'].find { |r| r['type'] == 'manga' }
     #     cover_art_filename = cover_art_api['data']['attributes']['fileName']
     #     @cover_art_urls[cover_art_manga['id']] = MangaDexService.new.get_cover_art(cover_art_manga['id'], cover_art_filename)
     #   end
     # end
     @cover_art_urls[manga['id']] = MangaDexService.new.get_cover_art(manga)
    end
    Rails.logger.debug("Cover art: #{@cover_art_urls.inspect} \n")
    Rails.logger.debug("Auth: #{@auth.inspect} \n")
  end

  def show
    @manga = MangaDexService.new.get_manga(params[:id])
    @cover_art = MangaDexService.new.get_manga(@manga['id'])
    @chapters = MangaDexService.new.get_chapters(params[:id])

    Rails.logger.debug("Manga Data: #{@manga.inspect} \n")
    Rails.logger.debug("Chapters Data: #{@chapters.inspect} \n")

    if @manga.success?
      @manga = @manga['data']
      #cover_art_relation = @manga['relationships'].find { |r| r['type'] == 'cover_art' }
      #if cover_art_relation
      #  cover_art_id = cover_art_relation['id']
        
        # Fetch detailed cover art info
      #  cover_art_filename = @manga.dig('attributes', 'cover_art', 'attributes', 'fileName')

      #  manga_id = @manga['id']
      #  @cover_art_url = "https://uploads.mangadex.org/covers/#{manga_id}/#{cover_art_filename}.256.jpg"
      #end
    else
      @manga = {} # or handle the error as needed
    end

    if @chapters && @chapters['data']
      @chapters = @chapters['data']
    else
      @chapters = [] # or handle the error as needed
    end

    if params[:chapter_id]
      @chapter_data = MangaDexService.new.get_chapter_pages(params[:chapter_id])
      Rails.logger.debug("Chapter Data: #{@chapter_data.inspect} \n")
    end
    
  end  

  def test
  end

end
