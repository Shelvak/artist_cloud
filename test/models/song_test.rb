require 'test_helper'

class SongTest < ActiveSupport::TestCase
  def setup
    @song = Fabricate(:song)
  end

  test 'create' do
    assert_difference ['Song.count', 'PaperTrail::Version.count'] do
      Song.create! Fabricate.attributes_for(:song, user_id: @song.user_id)
    end
  end

  test 'update' do
    assert_difference 'PaperTrail::Version.count' do
      assert_no_difference 'Song.count' do
        @song.update!(title: 'Updated')
      end
    end

    assert_equal 'Updated', @song.reload.title
  end

  test 'destroy' do
    assert_difference 'PaperTrail::Version.count' do
      assert_difference('Song.count', -1) { @song.destroy }
    end
  end

  test 'validates blank attributes' do
    @song.file = ''
    @song.title = ''
    @song.artist = ''
    @song.user_id = ''

    assert @song.invalid?
    assert_equal 3, @song.errors.size
    [:title, :artist, :user_id].each do |attr|
      assert_equal_messages @song, attr, :blank
    end

    @song = Song.new

    assert @song.invalid?
    assert_equal 4, @song.errors.size
    [:file, :title, :artist, :user_id].each do |attr|
      assert_equal_messages @song, attr, :blank
    end
  end
end
