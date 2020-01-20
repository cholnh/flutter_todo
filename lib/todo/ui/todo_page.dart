import 'package:flutter/material.dart';
import 'package:flutter_todo/todo/ui/test_page.dart';

class TodoPage extends StatelessWidget {
  TodoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Todo Page',
            ),
            RaisedButton(
              child: Text('Test'),
              onPressed: () => Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => TestPage()
              )),
            )
          ],
        ),
      ),
    );
  }
}
