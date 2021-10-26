import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_new/constraints.dart';
import 'package:flutter_new/secret.dart';
import 'package:flutter_new/server.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final pageName = 'AuthRegister';

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController(text: Secret.profileInfo['userId']);

  TextEditingController _pwController = TextEditingController(text: Secret.profileInfo['password']);

  TextEditingController _nickController = TextEditingController(text: Secret.profileInfo['nickname']);

  TextEditingController _nameController = TextEditingController(text: Secret.profileInfo['name']);

  var _dateTime=DateTime.parse(Secret.profileInfo['DOB']);

  TextEditingController _phoneController = TextEditingController(text: Secret.profileInfo['phone']);

  TextEditingController _addressController = TextEditingController(text: Secret.profileInfo['address']);

  TextEditingController _detailAddressController = TextEditingController(text: Secret.profileInfo['detailAddress']);

  TextEditingController _postNumberController = TextEditingController(text: Secret.profileInfo['postNumber']);

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
                      Row(
                        children: [
                          Expanded(
                            child: buildTextFormField(
                              context,
                              _idController,
                              Icon(Icons.account_circle),
                              'ID',
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          buildTextButton(context, Text('Check'), () {}),
                        ],
                      ),
                      buildTextFormField(
                        context,
                        _pwController,
                        Icon(Icons.vpn_key),
                        'PW',
                        obscureText: true,
                      ),
                      buildTextFormField(
                        context,
                        null,
                        Icon(Icons.vpn_key_outlined),
                        'PW Check',
                        obscureText: true,
                      ),
                      buildTextFormField(
                        context,
                        _nickController,
                        Icon(Icons.assignment_ind_outlined),
                        'NickName',
                      ),
                      buildTextFormField(
                        context,
                        _nameController,
                        Icon(Icons.assignment_ind),
                        'Name',
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        height: 150,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: _dateTime,
                          onDateTimeChanged: (dateTime) {
                            setState(() {
                              _dateTime=dateTime;
                              print(_dateTime.toString().substring(0,10));
                            });
                          },
                        ),
                      ),
                      buildTextFormField(
                          context,
                          _phoneController,
                          Icon(Icons.call),
                          'Phone',
                          inputFormatters: [ FilteringTextInputFormatter.digitsOnly],
                          keyboardType: TextInputType.number
                      ),
                      buildTextFormField(
                          context,
                          _addressController,
                          Icon(Icons.house),
                          'Address',
                          keyboardType: TextInputType.streetAddress
                      ),
                      buildTextFormField(
                        context,
                        _detailAddressController,
                        Icon(Icons.house),
                        'DetailAddress',
                      ),
                      buildTextFormField(
                        context,
                        _postNumberController,
                        Icon(Icons.house),
                        'PostNumber',
                      ),

                      // Container(child: buildTextButton("Sign Up",g3,Colors.white),width: MediaQuery.of(context).size.width,),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child:
                            buildTextButton(context, Text('Sign Up'), () {
                              print(_phoneController.text);
                              server.getReq("signup",
                                  userId: _idController.text.toString(),
                                  password: _pwController.text.toString(),
                                  nickname: _nickController.text.toString(),
                                  name: _nameController.text.toString(),
                                  DOB: _dateTime.toString().substring(0,10),
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
                            child: buildTextButton(
                                context, Text('Back to Main'), () {
                              // _authProvider.updateStatePage('AuthLogin');
                              Navigator.pop(context);
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
        ),
      ),
    );
  }
}
