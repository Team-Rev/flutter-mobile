import 'package:flutter/material.dart';
import 'package:flutter_new/repo/ask.dart';
import 'package:provider/provider.dart';

import '../../../../constraints.dart';
import '../../../../secret.dart';
import '../../../../server.dart';

class CreateAskDetail extends StatelessWidget {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: primaryColor,
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 36, vertical: 0),
                    child: Text(
                      '새 질문 작성',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        elevation: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: TextFormField(
                              controller: _titleController,
                              maxLines: 30,
                              validator: primaryValidator,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '제목을 입력하세요.',
                              ),
                            ),
                          ),
                        )),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.6,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        elevation: 7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: TextFormField(
                              controller: _contentController,
                              maxLines: 30,
                              validator: primaryValidator,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '질문을 입력하세요.',
                              ),
                            ),
                          ),
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildTextButton(context, Text('돌아가기'), () {
                        Navigator.pop(context);
                      }),
                      buildTextButton(context, Text('제출'), () {
                        server.getReq('createNewAsk',
                            title: _titleController.text,
                            content: _contentController.text,
                            context: context);
                      }),
                    ],
                  )
                ])));
  }
}
