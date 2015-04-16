class Mark
  constructor: (char) ->
    @char = char

  isValid: ->
    if !@char || @char.length == 0 || @char.length > 1
      false
    else
      true
