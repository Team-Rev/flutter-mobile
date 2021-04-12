import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
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
              children: [
                SizedBox(height: 64,),
                SizedBox(
                  height: 64,
                  child: Image.asset('assets/512.png'),
                ),
                SizedBox(height: 32,),
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
                        Row(children: [
                          Expanded(child: buildTextFormField(_idController, Icon(Icons.account_circle),'ID',),),
                          SizedBox(width: 16,),
                          buildTextButton('Check', g3, Colors.white),
                        ],),
                        buildTextFormField(_pwController, Icon(Icons.vpn_key), 'PW',),
                        buildTextFormField(_pwController, Icon(Icons.vpn_key_outlined), 'PW Check',),
                        buildTextFormField(_pwController, Icon(Icons.person), 'Name',),
                        buildTextFormField(_pwController, Icon(Icons.email), 'Email',),
                        buildTextFormField(_pwController, Icon(Icons.call), 'Contect',),
                        buildTextFormField(_pwController, Icon(Icons.house), 'Address',),
                        SizedBox(height: 16.0,),
                        // Container(child: buildTextButton("Sign Up",g3,Colors.white),width: MediaQuery.of(context).size.width,),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [

                          Container(child: buildTextButton('Sign Up', g3, Colors.white),width: MediaQuery.of(context).size.width*0.3,),
                          Container(child: buildTextButton('Back to Main', g3, Colors.white),width: MediaQuery.of(context).size.width*0.3,),
                        ],),
                        SizedBox(height: 16.0,),
                        // Container(child: buildTextButton("Forgot ID or Password?",Colors.transparent,Colors.grey),alignment:Alignment.centerRight),
                      ],
                    ),
                  ),
                ),
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