AudioControlsInitialized = false

InitializeAudioControls = ->
  playlist = $('#playListContainer')

  if (playlist.find('li').length)
    playlist.audioControls
      autoPlay : false,
      timer: 'increment',
      onAudioChange: (response) ->
        $('.songPlay').text(response.title + ' ...')
      onVolumeChange: (vol) ->
        if vol == 0
          klass = 'mute'
        else if vol > 66
          klass = 'volume3'
        else if vol > 33
          klass = 'volume2'
        else
          klass = 'volume1'

        $('.volume').attr('class','volume ' + klass)

    AudioControlsInitialized = true


$(document).on 'page:change', InitializeAudioControls

$(document).on 'ajax:success', '.toggle_song_from_playlist', (e, data, status)->
  songRow = $(data)
  dataCell = songRow.find('.take-me-out').remove()
  action = dataCell.attr('data-action')
  songUUID = dataCell.attr('data-uuid')

  if action == 'remove'
    songSrc = dataCell.attr('data-src')
    songName = dataCell.text()

    $('#playListContainer').append(
      "<li data-uuid=\"#{songUUID}\" data-src=\"#{songSrc}\">#{songName}</li>"
    )
  else
    $('#playListContainer').find('[data-uuid="' + songUUID + '"]').remove()

  $(this).parents('tr:first').replaceWith(songRow)

  if AudioControlsInitialized == false
    InitializeAudioControls()
