import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../secret.dart';

class MainProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 300,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('토큰 \n ${Secret.token}'),
                Text(
                    '\n해석하면 \n\nUserId : ${Secret.getSub}\nIAT : ${Secret.getIat}\nEXP : ${Secret.getExp}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
