import 'package:flutter/cupertino.dart';

class Boards {
  static var _boardPined = [];

  static get boardPined => _boardPined;

  static void initBoardsPined(var value) {
    _boardPined = value;
    print(_boardPined);
    print('initBoardsPined complete');
  }
  static dynamic _boardPage = [];

  static get boardPage => _boardPage;

  static void initBoardsPage(var value) {
    _boardPage = value;
    print(_boardPage);
    print('initBoardsPage complete');
  }
}
class BoardProvider extends ChangeNotifier {

  int _boardNum=0;
  bool _isPined=false;
  int _maxPage=0;

  get boardNum => _boardNum;
  get isPined => _isPined;
  get maxPage => _maxPage;

  void updatePage(int boardNum, bool isPined) {
    _boardNum=boardNum;
    _isPined=isPined;
    _maxPage = isPined ? Boards.boardPined.length : Boards.boardPage.length;
    notifyListeners();
  }

  void previousPage() {
    _boardNum--;
    notifyListeners();
  }

  void nextPage() {
    _boardNum++;
    notifyListeners();
  }

}