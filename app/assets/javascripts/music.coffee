new Rule
  load: ->
    @map.magicAudioControls ||= () ->
      $("#playListContainer").audioControls
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


    $(document).on('ready', @map.magicAudioControls)

  unload: ->
    $(document).off('ready', @map.magicAudioControls)
