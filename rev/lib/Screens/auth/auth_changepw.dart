import 'package:flutter/material.dart';
import 'package:flutter_new/server.dart';

import '../../constraints.dart';

class ChangePassword extends StatefulWidget {

  const ChangePassword({Key key, this.userId}) : super(key: key);
  final userId;
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.only(top: 32, bottom: 8),
                child: Column(
                  children: [
                    SizedBox(
                      height: 64,
                      child: Image.asset(
                        'assets/images/onepasslogo.png',
                        color: textPrimaryColor,
                      ),
                    ),
                    Text(
                      'One Pass',
                      style: TextStyle(
                          fontSize: 12,
                          color: textPrimaryColor,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                //카드 색
                color: textPrimaryColor,
                elevation: 7,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      buildTextFormField(
                        context,
                        _pwController,
                        Icon(Icons.vpn_key),
                        'PW',
                        obscureText: true,
                        validator: (text) {
                          if(text==null||text.isEmpty) {
                            return 'Please input correctly';
                          }
                          else if(text.length<8) {
                            return 'Password must be at least 8 characters.';
                          }
                        }
                      ),
                      buildTextFormField(
                        context,
                        null,
                        Icon(Icons.vpn_key_outlined),
                        'PW Check',
                        obscureText: true,
                          validator: (text) {
                            if(text==null||text.isEmpty) {
                              return 'Please input correctly.';
                            }
                            else if(text!=_pwController.text) {
                              return 'Password is different.';
                            }
                          }
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child:
                                buildTextButton(context, Text('Sign Up'), () {
                              if(_formKey.currentState.validate()) {
                                server.getReq('changePW', userId: widget.userId, password: _pwController.text, context: context);
                              }
                            }),
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                          Container(
                            child: buildTextButton(
                                context, Text('Back to Main'), () {
                              // _authProvider.updateStatePage('AuthLogin');
                              Navigator.pop(context);
                            }),
                            width: MediaQuery.of(context).size.width * 0.3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
