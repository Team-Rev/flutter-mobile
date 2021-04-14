
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/dio_server.dart';

class LoginPage extends StatelessWidget {
  GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  Color g1=Color.fromRGBO(102,239,156,1.0);
  Color g2=Color.fromRGBO(157,255,205,1.0);
  Color g3=Color.fromRGBO(37,188,109,1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      //배경색
      backgroundColor: g2,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset('assets/512.png'),
              ),
              SizedBox(height: 100,),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                //카드 색
                color: g1,
                elevation: 7,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      buildTextFormField(_idController, Icon(Icons.account_circle),'ID',),
                      buildTextFormField(_pwController, Icon(Icons.vpn_key), 'PW',),
                      SizedBox(height: 16.0,),
                      Container(child: buildTextButton("Sign In",g3,Colors.white),width: MediaQuery.of(context).size.width,),
                      Container(child: buildTextButton("Forgot ID or Password?",Colors.transparent,Colors.grey),alignment:Alignment.centerRight),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32,),

              buildTextButton("Create your New Account",Colors.transparent,Colors.grey),


            ],
          ),
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
        errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),

      ),
      validator: (text) {

          if (text==null||text.isEmpty) return 'Please input correctly';
        return null;
      },
    );
  }
}