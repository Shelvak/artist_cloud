class MusicController < ApplicationController
  before_action :init_song_ids
  before_action :set_music_song, only: [:remove_from_list, :add_to_list]

  def index
    @songs = Song.all.default_order.page(params[:page])

    @playlist = Song.where(id: song_ids)
  end

  def add_to_list
    session[:song_ids] << id unless song_ids.include?(id)

    render partial: 'song', locals: {
      song: @song, playlist: [@song], dynamic: true
    }
  end

  def remove_from_list
    session[:song_ids].delete(id)

    render partial: 'song', locals: {
      song: @song, playlist: [], dynamic: true
    }
  end

  private

    def init_song_ids
      session[:song_ids] ||= []
    end

    def song_ids
      session[:song_ids]
    end

    def id
      params[:id]
    end

    def set_music_song
      @song = Song.find(id)
    end
end
