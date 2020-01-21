import 'package:flutter/material.dart';
import 'package:flutter_todo/common/route/config/application.dart';

class HomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Application.router.navigateTo(context, '/asd'),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}
