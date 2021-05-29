class Boards {
  static var _boardPined = [];

  static get boardPined => _boardPined;

  //TODO 객체 메소드 안에 넣을 수 있을거같은데?
  static void initBoardsPined(var value) {
    _boardPined = value;
    // print(_boardSummary);
  }
  static dynamic _boardPage = [];

  static get boardPage => _boardPage;

  //TODO 객체 메소드 안에 넣을 수 있을거같은데?
  static void initBoardsPage(var value) {
    _boardPage = value;
    print(_boardPage);
  }
}
