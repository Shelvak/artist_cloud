module MusicHelper
  def get_action_for_song(song, playlist)
    playlist.map(&:id).include?(song.id) ? 'remove' : 'add'
  end

  def link_to_add_or_remove_song(song, action)
    @add_button ||= '<i class="mdi-action-alarm-add"></i>'.html_safe
    @remove_button ||= '<i class="mdi-action-highlight-remove"></i>'.html_safe

    button, link = if action == 'remove'
                     [@remove_button, remove_from_list_music_path(song.id)]
                   else
                     [@add_button, add_to_list_music_path(song.id)]
                   end

     link_to button, link,
       class: 'toggle_song_from_playlist',
       data: { remote: true, method: :patch, type: :html }
  end
end
