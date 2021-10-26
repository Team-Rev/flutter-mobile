import 'package:flutter/material.dart';
import 'package:flutter_new/constraints.dart';
import 'package:flutter_new/server.dart';

class AuthFind extends StatefulWidget {
  final pageName = 'AuthFind';

  @override
  _AuthFindState createState() => _AuthFindState();
}

class _AuthFindState extends State<AuthFind> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  bool whatToFind = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 120),
                child: Column(
                  children: [
                    SizedBox(
                      height: 120,
                      child: Image.asset(
                        'assets/images/onepasslogo.png',
                        color: textPrimaryColor,
                      ),
                    ),
                    Text(
                      'One Pass',
                      style: TextStyle(
                          fontSize: 28,
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
                          buildPrimaryTextOnlyButton(
                              context,
                              Text(
                                'Find ID',
                                style: TextStyle(
                                  color: whatToFind
                                      ? Colors.black45
                                      : Colors.black87,
                                  fontSize: 18,
                                  fontWeight: whatToFind
                                      ? FontWeight.w400
                                      : FontWeight.w600,
                                ),
                              ), () {
                            setState(() {
                              whatToFind = true;
                            });
                          }),
                          buildPrimaryTextOnlyButton(
                              context,
                              Text(
                                'Find PW',
                                style: TextStyle(
                                  color: whatToFind
                                      ? Colors.black87
                                      : Colors.black45,
                                  fontSize: 18,
                                  fontWeight: whatToFind
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ), () {
                            setState(() {
                              whatToFind = false;
                            });
                          }),
                        ],
                      ),
                      buildTextFormField(
                          context,
                          _nameController,
                          Icon(Icons.account_circle),
                          'NAME', validator: primaryValidator),
                      AnimatedContainer(
                        height: whatToFind ? 0 : 64,
                        duration: Duration(milliseconds: 300),
                        child: whatToFind
                            ? null
                            : buildTextFormField(
                                context,
                                _usernameController,
                                Icon(Icons.account_circle_outlined),
                                'USERID', validator: primaryValidator),
                      ),
                      buildTextFormField(context, _phoneController,
                          Icon(Icons.vpn_key), 'PHONE', obscureText: true,
                          validator: primaryValidator),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: buildTextButton(context,
                                  Text(whatToFind ? "Find ID" : "Find PW"), () {
                                if(_formKey.currentState.validate()){
                                if (whatToFind) {
                                  server.getReq('findID',
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      context: context);
                                } else {
                                  server.getReq('findPW',
                                      name: _nameController.text,
                                      userId: _usernameController.text,
                                      phone: _phoneController.text,
                                      context: context);
                                }
                                }

                              }),
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                            Container(
                              child: buildTextButton(
                                  context, Text("Back to Menu"), () {
                                Navigator.pop(context);
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
        ),
      ),
    );
  }
}
