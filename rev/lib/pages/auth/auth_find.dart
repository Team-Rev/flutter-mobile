import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/provider/provider_auth.dart';

import '../../util/color_rev.dart';
import '../../util/reusable.dart';

class AuthFind extends StatefulWidget {
  final pageName = 'AuthFind';

  @override
  _AuthFindState createState() => _AuthFindState();
}

class _AuthFindState extends State<AuthFind> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();

  TextEditingController _pwController = TextEditingController();
  AuthProvider _authProvider;

  bool whatToFind = true;

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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32)),
            //카드 색
            color: ColorRev.white,
            elevation: 7,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ButtonBar(
                    alignment: MainAxisAlignment.end,
                    children: [
                      ReUsable.buildTextButton3(
                        'Find ID',
                        () {
                          setState(() {
                            whatToFind = true;
                          });
                        },
                        style: TextStyle(
                          color: whatToFind ? Colors.black45 : Colors.black87,
                          fontSize: 18,
                          fontWeight:
                              whatToFind ? FontWeight.w400 : FontWeight.w600,
                        ),
                      ),
                      ReUsable.buildTextButton3(
                        'Find PW',
                        () {
                          setState(() {
                            whatToFind = false;
                          });
                        },
                        style: TextStyle(
                          color: whatToFind ? Colors.black87 : Colors.black45,
                          fontSize: 18,
                          fontWeight:
                              whatToFind ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
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
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: ReUsable.buildTextButton2(
                              whatToFind ? "Find ID" : "Find PW", () {}),
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                        Container(
                          child:
                              ReUsable.buildTextButton2("Back to Menu", () {
                            _authProvider.updateStatePage('AuthLogin');
                          }),
                          width: MediaQuery.of(context).size.width * 0.3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
