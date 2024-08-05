require_relative '../service/api_service'

class MangaController < ApplicationController
  def index
    @manga_list = Manga.all # Assuming Manga model exists, adjust if needed
    @comments = Comment.all.order(created_at: :desc)
  end
  
  def index
    @manga_list = MangaDexService.new.get_manga_list
  end

  def show
    @manga = MangaDexService.new.get_manga(params[:id])
    @chapters = MangaDexService.new.get_chapters(params[:id])

    Rails.logger.debug("Manga Data: #{@manga.inspect}")
    Rails.logger.debug("Chapters Data: #{@chapters.inspect}")

    if @manga.success?
      @manga = @manga['data']
    else
      @manga = {} # or handle the error as needed
    end

    if @chapters && @chapters['data']
      @chapters = @chapters['data']
    else
      @chapters = [] # or handle the error as needed
    end

    Rails.logger.debug("Chapters Data Structure: #{@chapters.inspect}")
    
  end  

end
