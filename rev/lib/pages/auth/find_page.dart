import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/provider/provider_auth.dart';

import '../../color_rev.dart';
import '../../reusable.dart';

class FindPage extends StatefulWidget {
  final pageName = 'FindPage';

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();

  TextEditingController _pwController = TextEditingController();
  AuthProvider _authProvider;

  bool whatToFind = true;

  @override
  Widget build(BuildContext context) {
    _authProvider=Provider.of<AuthProvider>(context);
    return Padding(
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
            SizedBox(
              height: 100,
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
                            child: ReUsable.buildTextButton2(
                                "Back to Menu", () {_authProvider.updateStatePage('LoginPage');}),
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
      ),
    );
  }
}
