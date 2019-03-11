// Generated by CoffeeScript 1.9.0
describe('WebUi', function() {
  return it('fills a slot with a mark', function() {
    var ui;
    setFixtures("<div data-slot=one></div><div data-slot=one></div>");
    ui = new WebUi;
    ui.startTicTacToe();
    $('[data-slot=one]').click();
    $('[data-slot=two]').click();
    expect($('[data-slot=one]').val()).toEqual("X");
    return expect($('[data-slot=two]').val()).toEqual("O");
  });
});