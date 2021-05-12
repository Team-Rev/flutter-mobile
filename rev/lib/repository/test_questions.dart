
class Questions {
  static List<String> _questionList = [];
  static get questionList => _questionList;

  static List<Map<String, int>> _answerList = [];
  static get answerList => _answerList;

  static List<List<int>> _submitList = [];
  static get submitList => _submitList;

  static List<int> _questionNumList = [];
  static get questionNumList => _questionNumList;

  static Map<String, dynamic> _questionResult;
  static get questionResult => _questionResult;

  static void initQuestionResult(dynamic value) {
    _questionResult=value;
  }

  static void init(dynamic value) {
    _question.clear();
    _questionList.clear();
    _answerList.clear();
    _submitList.clear();
    _question=value;
    print(_question);
    if(_submitList.length==0)
      for(int i=0;i<value.length;i++) {
        _submitList.add([]);
        _questionNumList.add(value[i]["id"]);
      }
    for (int i = 0; i < value.length; i++) {
      _questionList.add(value[i]["exam"]);

      Map<String, int> answer = {};
      for (int j = 0; j < value[i]["choices"].length; j++) {
        answer.addAll(
            {value[i]["choices"][j]["choice"]: value[i]["choices"][j]["id"]});
      }
      _answerList.add(answer);
    }
    print("submitValue : $_submitList");
  }
  // static get questionLength => _question.length;
  // static get question => _question;

  static var _question =[];
}
