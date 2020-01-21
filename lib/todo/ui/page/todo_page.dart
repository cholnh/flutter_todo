import 'package:flutter/material.dart';
import 'package:flutter_todo/todo/provider/provider.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatelessWidget {
  TodoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Todo Page',
          ),
          Consumer<CounterProvider>(
              builder: (context, counter, child) {
                return Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.display1,
                );
              }
          ),
        ],
      ),
    );
  }
}
