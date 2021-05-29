class Boards {
  static var _boardSummary = [];

  static get boardSummary => _boardSummary;

  //TODO 객체 메소드 안에 넣을 수 있을거같은데?
  static void initBoards(var value) {
    _boardSummary = value;
    // print(_boardSummary);
  }
}
