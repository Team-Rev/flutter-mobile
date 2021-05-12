class Results {
  static var _resultList = [];

  static get resultList => _resultList;

  static void init(var value) {
    _resultList = value;
    print(_resultList);
  }
}
