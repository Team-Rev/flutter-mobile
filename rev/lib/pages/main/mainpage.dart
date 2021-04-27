
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/dio_server.dart';

import '../../color_rev.dart';

class MainPage extends StatelessWidget {
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        //배경색
        backgroundColor: ColorRev.g2,
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                color: ColorRev.white,
                child: ButtonBar(
                  alignment: MainAxisAlignment.center,
                  buttonPadding: EdgeInsets.all(10),
                  children: [
                    TextButton(child: Icon(Icons.account_circle_outlined),), // 사용자 on
                    // TextButton(child: Icon(Icons.account_circle,color: g1,),), // 사용자 off

                    SizedBox(
                      width: 30,
                      child: Text('|', style: TextStyle(color: ColorRev.grey),),
                    ),
                    // TextButton(child: Icon(Icons.assignment, color: g1,),), // 게시판 off
                    TextButton(child: Icon(Icons.assignment_outlined,),), // 게시판 on
                    SizedBox(
                      width: 30,
                      child: Text('|', style: TextStyle(color: ColorRev.grey),),
                    ),
                    // TextButton(child: Icon(Icons.wb_incandescent_outlined),), // 문제 off
                    TextButton(child: Icon(Icons.wb_incandescent, color: ColorRev.g1,),), // 문제 on
                  ],
                ),
              ),
              // Card(
              //   color: Colors.white,
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     mainAxisAlignment: MainAxisAlignment.end,
              //     children: [
              //       Text('오늘도 열심히!',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0,),),
              //       Text('OOO 님 사용중',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 32.0,)),
              //     ],
              //   ),
              // )
            ],
          ),
        )

    );
  }
  //버튼 생성
  TextButton buildTextButton(String text, Color color, Color fontColor,) {
    return TextButton(
      onPressed: () {
        if(_formKey.currentState.validate()) {
          print(_idController.text);
          print(_pwController.text);
          server.postReq(username: _idController.text,password: _pwController.text);
        }
      },
      child: Text(text),
      style: TextButton.styleFrom(primary: fontColor,backgroundColor: color),
    );
  }
  //필드 생성
  TextFormField buildTextFormField(TextEditingController controller, Icon icon, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: icon,
        labelText: labelText,
        errorStyle: TextStyle(color: ColorRev.red,fontWeight: FontWeight.bold),
      ),
      validator: (text) {

        if (text==null||text.isEmpty) return 'Please input correctly';
        return null;
      },
    );
  }
}