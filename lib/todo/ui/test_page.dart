import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  TestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Test Page',
            ),
          ],
        ),
      ),
    );
  }
}
