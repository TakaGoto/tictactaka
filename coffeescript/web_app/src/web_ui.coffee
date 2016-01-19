class WebUi
  startTicTacToe: ->
    $('[data-slot=one]').bind("click", (event) ->
      $('[data-slot=one]').val("O")
    )
