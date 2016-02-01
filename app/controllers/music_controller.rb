class MusicController < ApplicationController
  def index

    if params[:q]
      @songs = Song.filtered_list(params[:q])
    else
      @songs = Song.suggested
    end

    @songs = @songs.page(params[:page])
  end
end
