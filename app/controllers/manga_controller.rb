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

    @cover_art_urls = Rails.cache.fetch("cover_art_urls_#{params[:query]}", expires_in: 5.minutes) do
      fetch_cover_art_urls(@manga_list['data']) if @manga_list
    end
    #Rails.logger.debug("Cover art: #{@cover_art_urls.inspect} \n")
  end

  def show
    @manga = Rails.cache.fetch("manga_#{params[:id]}", expires_in: 5.minutes) do
      @manga_service.get_manga(params[:id])['data'] if @manga_service
    end
    #Rails.logger.debug("Manga Data: #{@manga.inspect} \n")

    chapters_list_response = Rails.cache.fetch("chapters_list_#{params[:id]}", expires_in: 5.minutes) do
      fetch_sorted_chapters(@manga_service.get_chapters(params[:id])['data']) if @manga_service
    end
    @chapters_list = chapters_list_response.reverse if chapters_list_response
    #Rails.logger.debug("Chapters List: #{@chapters_list.inspect} \n")

    @cover_art = @manga ? @manga_service.get_cover_art(@manga) : nil
    #Rails.logger.debug("Cover art: #{@cover_art.inspect} \n")

    @comments = Comment.where(manga_ref: params[:id])
    #Rails.logger.debug("Comments: #{@comments.inspect} \n")
  end

  def chapter_pages
    @manga_id = params[:id]
    @chapter_id = params[:chapter_id]
    @manga_title = fetch_manga_title(@manga_id)

    chapters_list_response = Rails.cache.fetch("chapters_list_#{@manga_id}", expires_in: 5.minutes) do
      @manga_service.get_chapters(@manga_id)['data'] if @manga_service
    end

    @chapters_list = fetch_sorted_chapters(chapters_list_response) if chapters_list_response

    @chapter_number = fetch_chapter_number(@chapter_id, chapters_list_response) if @chapters_list
    current_chapter_index = @chapters_list.find_index { |c| c['id'] == @chapter_id } if @chapters_list
    @current_chapter = @chapters_list[current_chapter_index] if current_chapter_index

    @chapter_data = Rails.cache.fetch("chapter_pages_#{@chapter_id}", expires_in: 5.minutes) do
      @manga_service.get_chapter_pages(@chapter_id)
    end || {}
    #Rails.logger.debug("Chapter Pages: #{@chapter_data.inspect} \n")

    @all_pages = @chapter_data.values

    @page_index = params[:page].to_i || 0
    @current_page = @chapter_data[@page_index]

    @previous_chapter_id = previous_chapter_id(current_chapter_index)
    @next_chapter_id = next_chapter_id(current_chapter_index)
  end

  def test
  end

  private

  def set_manga_service
    @manga_service = MangaDexService.new
  end

  def fetch_cover_art_urls(manga_list)
    manga_list.each_with_object({}) do |manga, cover_art_urls|
      cover_art_urls[manga['id']] = @manga_service.get_cover_art(manga)
    end
  end

  def fetch_sorted_chapters(chapters_list_response)
    en_chapters = chapters_list_response.select { |chapter| chapter['attributes']['translatedLanguage'] == 'en' }
    en_chapters.sort_by do |chapter|
      chapter_number = chapter['attributes']['chapter']
      chapter_number.present? ? chapter_number.to_f : Float::INFINITY
    end
  end

  def fetch_manga_title(manga_id)
    Rails.cache.fetch("manga_title_#{manga_id}", expires_in: 5.minutes) do
      manga_response = @manga_service.get_manga(manga_id)['data']
      manga_response ? manga_response['attributes']['title']['en'] : 'Unknown'
    end
  end

  def fetch_chapter_number(chapter_id, chapters_list_response)
    Rails.cache.fetch("chapter_number_#{chapter_id}", expires_in: 5.minutes) do
      chapter = chapters_list_response.find { |c| c['id'] == chapter_id }
      chapter ? chapter['attributes']['chapter'] : 'Unknown'
    end
  end

  def previous_chapter_id(current_chapter_index)
    return nil if current_chapter_index.nil? || current_chapter_index <= 0
    @chapters_list[current_chapter_index - 1]['id']
  end
  
  def next_chapter_id(current_chapter_index)
    return nil if current_chapter_index.nil? || current_chapter_index >= @chapters_list.length - 1
    @chapters_list[current_chapter_index + 1]['id']
  end

end
