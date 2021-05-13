import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rev/util/color_rev.dart';

class ResultDetail extends StatelessWidget {
  const ResultDetail({Key key}) : super(key: key);

  Widget _buildResultDetail(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'asdf',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Text('asdfasdf'),
                    Text('asdfasdf'),
                    Text('asdfasdf'),
                    Text('asdfasdf'),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Divider(
                  height: 8,
                  thickness: 1,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorRev.g3,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 36, vertical: 0),
            child: Text(
              '문제 기록',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
                elevation: 7,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    int itemCount = 1;
                    if (itemCount > 0) return _buildResultDetail(index);
                    return Center(
                      child: Text(
                        '기록이 없습니다.',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                )),
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
