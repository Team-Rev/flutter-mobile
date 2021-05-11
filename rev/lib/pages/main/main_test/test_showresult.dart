import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/util/color_rev.dart';

class ShowResult extends StatelessWidget {
  const ShowResult({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRev.g3,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
              elevation: 7,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '문제 기록',
                      style: TextStyle(fontSize: 24, color: Colors.grey),
                    ),
                    Divider(
                      height: 8,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListView()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
