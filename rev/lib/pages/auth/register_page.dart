import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/provider/provider_auth.dart';

import '../../color_rev.dart';
import '../../reusable.dart';

class RegisterPage extends StatelessWidget {
  final pageName = 'RegisterPage';
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
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                  child: Image.asset(
                    'assets/512.png',
                    color: ColorRev.white,
                  ),
                ),
                Text(
                  'One Pass',
                  style: TextStyle(
                      fontSize: 14,
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
                  Row(
                    children: [
                      Expanded(
                        child: ReUsable.buildTextFormField(
                          _idController,
                          Icon(Icons.account_circle),
                          'ID',
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      ReUsable.buildTextButton2('Check', () {}),
                    ],
                  ),
                  ReUsable.buildTextFormField(
                    _pwController,
                    Icon(Icons.vpn_key),
                    'PW',
                  ),
                  ReUsable.buildTextFormField(
                    _pwController,
                    Icon(Icons.vpn_key_outlined),
                    'PW Check',
                  ),
                  ReUsable.buildTextFormField(
                    _pwController,
                    Icon(Icons.person),
                    'Name',
                  ),
                  ReUsable.buildTextFormField(
                    _pwController,
                    Icon(Icons.email),
                    'Email',
                  ),
                  ReUsable.buildTextFormField(
                    _pwController,
                    Icon(Icons.call),
                    'Contect',
                  ),
                  ReUsable.buildTextFormField(
                    _pwController,
                    Icon(Icons.house),
                    'Address',
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  // Container(child: buildTextButton("Sign Up",g3,Colors.white),width: MediaQuery.of(context).size.width,),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: ReUsable.buildTextButton2('Sign Up', () {}),
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Container(
                        child: ReUsable.buildTextButton2('Back to Main', () {
                          _authProvider.updateStatePage('LoginPage');
                        }),
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  // Container(child: buildTextButton("Forgot ID or Password?",Colors.transparent,Colors.grey),alignment:Alignment.centerRight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
