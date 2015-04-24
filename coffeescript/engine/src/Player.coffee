class Player
  TYPES =
    "1": "human"

  constructor: (options) ->
    @mark = new Mark(options.mark)
    @type = TYPES[options.type]
