class Ask {
  static var _askList=[];
  static get askList => _askList;
  static void initAskList(var value) {
    _askList=value;
  }
  static void _askComment=[];
  static get askComment=>_askComment;
  static void initAskComment(var value) {
    _askComment=value;
  }
}