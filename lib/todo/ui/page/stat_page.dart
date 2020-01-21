import 'package:flutter/material.dart';

class StatPage extends StatelessWidget {
  StatPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'stat Page',
          ),
        ],
      ),
    );
  }
}
