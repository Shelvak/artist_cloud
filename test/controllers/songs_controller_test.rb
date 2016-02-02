require 'test_helper'

class SongsControllerTest < ActionController::TestCase

  setup do
    @song = Fabricate(:song)
    @user = Fabricate(:user)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:songs)
    assert_select '#unexpected_error', false
    assert_template "songs/index"
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:song)
    assert_select '#unexpected_error', false
    assert_template "songs/new"
  end

  test "should create song" do
    assert_difference('Song.count') do
      file = Rack::Test::UploadedFile.new(
        Rails.root.join('test', 'files', 'sample.mp3'),
        'audio/mpeg'
      )
      post :create, song: Fabricate.attributes_for(:song, file: file)
    end

    assert_redirected_to song_url(assigns(:song))
  end

  test "should show song" do
    get :show, id: @song
    assert_response :success
    assert_not_nil assigns(:song)
    assert_select '#unexpected_error', false
    assert_template "songs/show"
  end

  test "should get edit" do
    get :edit, id: @song
    assert_response :success
    assert_not_nil assigns(:song)
    assert_select '#unexpected_error', false
    assert_template "songs/edit"
  end

  test "should update song" do
    put :update, id: @song,
      song: Fabricate.attributes_for(:song, attr: 'value')
    assert_redirected_to song_url(assigns(:song))
  end

  test "should destroy song" do
    assert_difference('Song.count', -1) do
      delete :destroy, id: @song
    end

    assert_redirected_to songs_url
  end
end
