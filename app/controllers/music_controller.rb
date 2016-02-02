class MusicController < ApplicationController
  def index
    if params[:q]
      @songs = Song.filtered_list(params[:q])
    else
      @songs = Song.suggested
    end

    @songs = @songs.default_order.page(params[:page])
  end
end
