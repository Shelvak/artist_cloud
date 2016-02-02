class SongsController < ApplicationController
  before_action :set_song, only:  [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  check_authorization
  load_and_authorize_resource

  # GET /songs
  def index
    @title = t('view.songs.index_title')
    @searchable = true
    @songs = songs_scope.filtered_list(params[:q]).
                         default_order.page(params[:page])
  end

  # GET /songs/1
  def show
    @title = t('view.songs.show_title')
  end

  # GET /songs/new
  def new
    @title = t('view.songs.new_title')
    @song = Song.new
  end

  # GET /songs/1/edit
  def edit
    @title = t('view.songs.edit_title')
  end

  # POST /songs
  def create
    @title = t('view.songs.new_title')
    @song = Song.new(song_params)

    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice: t('view.songs.correctly_created') }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /songs/1
  def update
    @title = t('view.songs.edit_title')

    respond_to do |format|
      if @song.update(song_params)
        format.html { redirect_to @song, notice: t('view.songs.correctly_updated') }
      else
        format.html { render action: 'edit' }
      end
    end
  rescue ActiveRecord::StaleObjectError
    redirect_to edit_song_url(@song), alert: t('view.songs.stale_object_error')
  end

  # DELETE /songs/1
  def destroy
    @song.destroy
    redirect_to songs_url, notice: t('view.songs.correctly_destroyed')
  end

  private

    def set_song
      @song = songs_scope.find(params[:id])
    end

    def songs_scope
      current_user.admin? ? Song.all : current_user.songs
    end

    def song_params
      _permitted = params.require(:song).permit(
        :file, :title, :artist, :album, :year, :comment, :track, :genre,
      )
      # If an admin change the file that shouldn't change of owner
      _permitted['user_id'] = @song.try(:user_id) || current_user.id
      _permitted
    end
end
