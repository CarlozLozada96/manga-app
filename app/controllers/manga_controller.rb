require_relative '../service/api_service'

class MangaController < ApplicationController
  before_action :set_manga_service

  def index
    @manga_list = @manga_service.get_manga_list
    #Rails.logger.debug("Manga list: #{@manga_list.inspect} \n")

    @cover_art_urls = {}
    @manga_list['data'].each do |manga|
      @cover_art_urls[manga['id']] = @manga_service.get_cover_art(manga)
    end
    #Rails.logger.debug("Cover art: #{@cover_art_urls.inspect} \n")
  end

  def show
    @comments = current_user.comments
    manga_response = @manga_service.get_manga(params[:id])
    @manga = manga_response['data'] if manga_response.success?
    Rails.logger.debug("Manga Data: #{@manga.inspect} \n")

    Rails.logger.debug("Comments: #{@comments.inspect} \n")

    chapters_list_response = @manga_service.get_chapters(params[:id])['data']
    if !chapters_list_response.nil?
      en_chapters = chapters_list_response.select do |chapter|
        chapter['attributes']['translatedLanguage'] == 'en'
      end

      @chapters_list = en_chapters.sort_by do |chapter|
        chapter_number = chapter['attributes']['chapter']
        chapter_number.present? ? chapter_number.to_f : Float::INFINITY
      end.reverse   
      Rails.logger.debug("Chapters List: #{@chapters_list.inspect} \n")
      end
    @cover_art = @manga_service.get_cover_art(@manga) if @manga
    #Rails.logger.debug("Cover art: #{@cover_art.inspect} \n")
  end

  def chapter_pages
    @manga_id = params[:id]
    @chapter_id = params[:chapter_id]
    @page_index = params[:page].to_i || 0

    @chapter_data = @manga_service.get_chapter_pages(@chapter_id)
    Rails.logger.debug("Chapter Pages: #{@chapter_data.inspect} \n")
    @current_page = @chapter_data[@page_index]
    
  end

  def test
  end

  private

  def set_manga_service
    @manga_service = MangaDexService.new
  end

end
