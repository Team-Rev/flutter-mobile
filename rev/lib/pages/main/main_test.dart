import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../dio_server.dart';
import '../../reusable.dart';

class MainTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(child: ReUsable.buildTextButton2('hihi',() {
          server.getReq();
        }),),
      ],
    );
  }
}
