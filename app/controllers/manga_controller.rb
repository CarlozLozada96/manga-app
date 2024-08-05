require_relative '../service/api_service'

class MangaController < ApplicationController
  def index
    @manga_list = MangaDexService.new.get_manga_list
    #Rails.logger.debug("Manga list: #{@manga_list.inspect} \n")

    @cover_art_urls = {}
    @manga_list['data'].each do |manga|
      @cover_art_urls[manga['id']] = MangaDexService.new.get_cover_art(manga)
    end
    #Rails.logger.debug("Cover art: #{@cover_art_urls.inspect} \n")
  end

  def show
    manga_response = MangaDexService.new.get_manga(params[:id])
    @manga = manga_response['data'] if manga_response.success?
    chapters_list = MangaDexService.new.get_chapters(params[:id])['data']
    @chapters_list = chapters_list.sort_by do |chapter|
      chapter_number = chapter['attributes']['chapter']
      chapter_number.present? ? chapter_number.to_f : Float::INFINITY
    end.reverse

    Rails.logger.debug("Manga Data: #{@manga.inspect} \n")
    Rails.logger.debug("Chapters List: #{chapters_list.inspect} \n")

    if @manga
      @cover_art = MangaDexService.new.get_cover_art(@manga)
    else
      @manga = {} # or handle the error as needed
    end
    #Rails.logger.debug("Cover art: #{@cover_art.inspect} \n")

    #if @chapters && @chapters['data']
    #  @chapters = @chapters['data']
    #else
    #  @chapters = [] # or handle the error as needed
    #end

    if params[:chapter_id]
      @chapter_data = MangaDexService.new.get_chapter_pages(params[:chapter_id])
      Rails.logger.debug("Chapter Data: #{@chapter_data.inspect} \n")
    end
    
  end  

  def test
  end

end
