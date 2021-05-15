class Results {
  static var _resultSummary = [];

  static get resultSummary => _resultSummary;

  static var _resultQuestions=[];
  static get resultQuestion=>_resultQuestions;
 //TODO 객체 메소드 안에 넣을 수 있을거같은데?
  static void initResultSummary(var value) {
    _resultSummary = value;
    print(_resultSummary);
  }
  static void initResultQuestions(var value) {
    _resultQuestions = value;
    print(_resultQuestions);
  }

}
