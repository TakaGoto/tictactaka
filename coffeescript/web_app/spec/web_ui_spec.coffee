describe 'WebUi', ->
  it 'fills a slot with a mark', ->
    setFixtures("<div data-slot=one></div><div data-slot=one></div>")

    ui = new WebUi
    ui.startTicTacToe()

    $('[data-slot=one]').click()
    $('[data-slot=two]').click()

    expect($('[data-slot=one]').val()).toEqual("X")
    expect($('[data-slot=two]').val()).toEqual("O")

