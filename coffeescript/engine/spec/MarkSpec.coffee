describe 'Mark', ->
  it 'is invalid if mark is empty', ->
    mark = new Mark("")
    expect(mark.isValid()).toBe(false)

  it 'is invalid if mark is not set', ->
    mark = new Mark
    expect(mark.isValid()).toBe(false)

  it 'is invalid if mark is more than one character', ->
    mark = new Mark("hello")
    expect(mark.isValid()).toBe(false)

  it 'is valid if mark is a one character string', ->
    mark = new Mark("x")
    expect(mark.isValid()).toBe(true)
