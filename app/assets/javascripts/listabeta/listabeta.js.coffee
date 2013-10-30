window.StartupNews =

  Common:
    init: ->
      @flash()

    flash: ->
      setTimeout( ->
        $('.flash').slideDown('slow')
      , 100)
      if $('.flash').length > 0
        setTimeout( ->
          $('.flash').slideUp('slow')
        , 4000)
      $('.flash').click ->
        $('.flash').slideUp()

jQuery ->
  StartupNews.Common.init()
