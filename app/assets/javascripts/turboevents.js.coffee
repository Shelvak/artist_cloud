Turbolinks.pagesCached 0

jQuery ($) ->
  $(document).on 'page:fetch',   -> $('.loading-caption').show().removeClass 'hide'
  $(document).on 'page:receive', -> $('.loading-caption').hide().addClass 'hide'
  $(document).on 'page:load',    -> $('[autofocus]').focus()
  $(document).on 'page:change', -> Inspector.instance().reload()
