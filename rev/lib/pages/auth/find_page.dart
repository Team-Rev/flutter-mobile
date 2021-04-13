import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _idController = TextEditingController();

  TextEditingController _pwController = TextEditingController();

  Color g1 = Color.fromRGBO(102, 239, 156, 1.0);

  Color g2 = Color.fromRGBO(157, 255, 205, 1.0);

  Color g3 = Color.fromRGBO(37, 188, 109, 1.0);

  bool whatToFind = true;

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
                SizedBox(
                  height: 100,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32)),
                  //카드 색
                  color: g1,
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
                            buildTextButton(
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
                              ),
                              Colors.transparent,
                              Colors.white,
                              onPressed: () {
                                setState(() {
                                  whatToFind = true;
                                });
                              },
                              padding: EdgeInsets.all(16.0),
                            ),
                            buildTextButton(
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
                              ),
                              Colors.transparent,
                              Colors.white,
                              onPressed: () {
                                setState(() {
                                  whatToFind = false;
                                });
                              },
                              padding: EdgeInsets.all(16.0),
                            ),
                          ],
                        ),
                        buildTextFormField(
                          _idController,
                          Icon(Icons.account_circle),
                          'ID',
                        ),
                        buildTextFormField(
                          _pwController,
                          Icon(Icons.vpn_key),
                          'PW',
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: buildTextButton(
                                  whatToFind
                                      ? Text("Find ID")
                                      : Text("Find PW"),
                                  g3,
                                  Colors.white),
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                            Container(
                              child: buildTextButton(
                                  Text("Back to Menu"), g3, Colors.white),
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16.0,
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
        ));
  }

  TextButton buildTextButton(Text, Color color, Color fontColor,
      {onPressed, padding}) {
    return TextButton(
      onPressed: onPressed,
      child: Text,
      style: TextButton.styleFrom(
          primary: fontColor, backgroundColor: color, padding: padding),
    );
  }

  TextFormField buildTextFormField(
      TextEditingController controller, Icon icon, String labelText) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        icon: icon,
        labelText: labelText,
        errorStyle: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      validator: (text) {
        if (text == null || text.isEmpty) return 'Please input correctly';
        return null;
      },
    );
  }
}
