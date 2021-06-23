import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rev/dio_server.dart';
import 'package:rev/provider/provider_auth.dart';

import '../../main.dart';
import '../../util/color_rev.dart';
import '../../util/reusable.dart';

class AuthRegister extends StatelessWidget {
  final pageName = 'AuthRegister';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController();
  TextEditingController _pwController = TextEditingController();
  TextEditingController _nickController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  TextEditingController _DOBController = TextEditingController();

  TextEditingController _phoneController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  TextEditingController _detailAddressController = TextEditingController();

  TextEditingController _postNumberController = TextEditingController();
  AuthProvider _authProvider;

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 32, bottom: 8),
            child: Column(
              children: [
                SizedBox(
                  height: 64,
                  child: Image.asset(
                    'assets/512.png',
                    color: ColorRev.white,
                  ),
                ),
                Text(
                  'One Pass',
                  style: TextStyle(
                      fontSize: 12,
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
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
                    null,
                    Icon(Icons.vpn_key_outlined),
                    'PW Check',
                  ),
                  ReUsable.buildTextFormField(
                    _nickController,
                    Icon(Icons.assignment_ind_outlined),
                    'NickName',
                  ),
                  ReUsable.buildTextFormField(
                    _nameController,
                    Icon(Icons.assignment_ind),
                    'Name',
                  ),
                  ReUsable.buildTextFormField(
                    _DOBController,
                    Icon(Icons.calendar_today),
                    'Birth',
                  ),
                  ReUsable.buildTextFormField(
                    _phoneController,
                    Icon(Icons.call),
                    'Phone',
                  ),
                  ReUsable.buildTextFormField(
                    _addressController,
                    Icon(Icons.house),
                    'Address',
                  ),
                  ReUsable.buildTextFormField(
                    _detailAddressController,
                    Icon(Icons.house),
                    'DetailAddress',
                  ),
                  ReUsable.buildTextFormField(
                    _postNumberController,
                    Icon(Icons.house),
                    'PostNumber',
                  ),

                  // Container(child: buildTextButton("Sign Up",g3,Colors.white),width: MediaQuery.of(context).size.width,),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: ReUsable.buildTextButton2('Sign Up', () {
                          server.doPost(context, "signup",
                              userId: _idController.text.toString(),
                              password: _pwController.text.toString(),
                              nickname: _nickController.text.toString(),
                              name: _nameController.text.toString(),
                              DOB: _DOBController.text.toString(),
                              phone: _phoneController.text.toString(),
                              address: _addressController.text.toString(),
                              detailAddress:
                                  _detailAddressController.text.toString(),
                              postNumber:
                                  _postNumberController.text.toString());
                        }),
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                      Container(
                        child: ReUsable.buildTextButton2('Back to Main', () {
                          // _authProvider.updateStatePage('AuthLogin');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                        }),
                        width: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ],
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
