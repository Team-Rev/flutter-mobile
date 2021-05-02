import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/dio_server.dart';
import 'package:rev/provider/provider_auth.dart';

import '../../color_rev.dart';
import '../../reusable.dart';

class AuthLogin extends StatelessWidget {
  final pageName = 'AuthLogin';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 120),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  child: Image.asset(
                    'assets/512.png',
                    color: ColorRev.white,
                  ),
                ),
                Text(
                  'One Pass',
                  style: TextStyle(
                      fontSize: 28,
                      color: ColorRev.white,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            //카드 색
            color: ColorRev.white,
            elevation: 7,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ReUsable.buildTextFormField(
                    _idController,
                    Icon(Icons.account_circle),
                    'ID',
                  ),
                  ReUsable.buildTextFormField(
                    _pwController,
                    Icon(Icons.vpn_key),
                    'PW',
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    child: ReUsable.buildTextButton2("Sign In", () {
                      // if (_formKey.currentState.validate()) {
                      //   print(_idController.text);
                      //   print(_pwController.text);
                      //   dynamic result=server.postReq(_authProvider,'SignIn',
                      //       username: _idController.text,
                      //       password: _pwController.text);
                      // }
                      _authProvider.goToMain();
                    }
                    ),
                    width: MediaQuery.of(context).size.width,
                  ),
                  Container(
                      child: ReUsable.buildTextButton4("Forget Id or Password?",
                          () {
                        _authProvider.updateStatePage('AuthFind');
                      }),
                      alignment: Alignment.centerRight),
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 32),
              child: ReUsable.buildTextButton3("Create your New Account", () {
                _authProvider.updateStatePage('AuthRegister');
              })),
        ],
      ),
    );
  }
}
