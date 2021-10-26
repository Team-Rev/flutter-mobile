import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_new/server.dart';

class Ask {
  static dynamic _askList=[];
  static get askList => _askList;
  static void initAskList(var value) {
    _askList=value;
    print('AskList init complete!');
    print('AskList length ${_askList.length}');
  }
  static bool isAskListEmpty() {
    return _askList.isEmpty;
  }
  static void refreshAskList() {
    _askList.clear();
    server.getReq('getAskList', page: 0);
  }

  static HashMap<int, dynamic> _askComment=HashMap();
  static get askComment=>_askComment;

  static void initAskComment(var value, int askId) {
    Set<dynamic> temp=_askComment[askId]?.toSet();
    if(_askComment.containsKey(askId)) {
      temp.add(value);
      _askComment[askId]=temp.toList();
    }
    else
      _askComment.addAll({askId : value});


    print(_askComment);
    print('AskComment init complete!');
  }

  static Future refreshComment(int askId) async {
    _askComment[askId].clear();
    server.getReq('getAskComment', askId: askId, page: 0);
  }

  static bool isAskCommentEmpty(int askId) {
    if (_askComment.containsKey(askId)) return false;
    return true;
  }

}

class AskProvider extends ChangeNotifier {

  int _askNum=0;
  int _maxPage=0;

  get askNum => _askNum;
  get maxPage => _maxPage;

  void updatePage(int askNum) {
    _askNum=askNum;
    _maxPage = Ask.askList.length;
    notifyListeners();
  }

  void previousPage() {
    _askNum--;
    notifyListeners();
  }

  void nextPage() {
    _askNum++;
    notifyListeners();
  }

}