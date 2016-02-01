new Rule
  load: ->
    @map.extractAudioTags ||= (e)->
      target = e.currentTarget
      if target && target.files
        file = target.files[0]

        jsmediatags.read(
          file
          onSuccess: (tag) ->
            for key in ['title', 'artist', 'album', 'genre', 'year', 'track']
              $('#song_' + key).val( tag.tags[key] )
            if tag.tags.comment
              $('#song_comment').val(tag.tags.comment.text)
          onError: (error) ->
            console.log(error)
        )

    $(document).on('change', '.extraible_file:file', @map.extractAudioTags)

  unload: ->
    $(document).off('change', '.extraible_file:file', @map.extractAudioTags)

