require_relative '../service/api_service'

class MangaController < ApplicationController
  before_action :set_manga_service

  def index
    @manga_list = Rails.cache.fetch("manga_list_#{params[:query]}", expires_in: 5.minutes) do
      if params[:query].present?
        @manga_service.search_manga(params[:query])
      else
        @manga_service.get_manga_list
      end
    end
    #Rails.logger.debug("Manga list: #{@manga_list.inspect} \n")

    @cover_art_urls = Rails.cache.fetch("cover_art_urls_#{params[:query]}", expires_in: 5.minutes) do
      @manga_list['data'].each_with_object({}) do |manga, cover_art_urls|
        cover_art_urls[manga['id']] = @manga_service.get_cover_art(manga)
      end
    end
    #Rails.logger.debug("Cover art: #{@cover_art_urls.inspect} \n")
  end

  def show
    @manga = Rails.cache.fetch("manga_#{params[:id]}", expires_in: 5.minutes) do
      manga_response = @manga_service.get_manga(params[:id])
      manga_response['data']
    end
    Rails.logger.debug("Manga Data: #{@manga.inspect} \n")

    chapters_list_response = Rails.cache.fetch("chapters_list_#{params[:id]}", expires_in: 5.minutes) do
      @manga_service.get_chapters(params[:id])['data']
    end

    en_chapters = chapters_list_response.select { |chapter| chapter['attributes']['translatedLanguage'] == 'en' }
    @chapters_list = en_chapters.sort_by do |chapter|
      chapter_number = chapter['attributes']['chapter']
      chapter_number.present? ? chapter_number.to_f : Float::INFINITY
    end.reverse  
    Rails.logger.debug("Chapters List: #{@chapters_list.inspect} \n")

    @cover_art = @manga_service.get_cover_art(@manga) if @manga
    #Rails.logger.debug("Cover art: #{@cover_art.inspect} \n")
  end

  def chapter_pages
    @manga_id = params[:id]
    @chapter_id = params[:chapter_id]

    @chapter_data = Rails.cache.fetch("chapter_pages_#{params[:chapter_id]}", expires_in: 5.minutes) do
      @manga_service.get_chapter_pages(params[:chapter_id])
    end || {}
    #Rails.logger.debug("Chapter Pages: #{@chapter_data.inspect} \n")

    @page_index = params[:page].to_i || 0
    @current_page = @chapter_data[@page_index]
  end

  def test
  end

  private

  def set_manga_service
    @manga_service = MangaDexService.new
  end

end
