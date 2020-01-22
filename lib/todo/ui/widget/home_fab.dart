import 'package:flutter/material.dart';
import 'package:flutter_todo/common/route/config/application.dart';
import 'package:flutter_todo/tab/tab.dart';
import 'package:provider/provider.dart';

class HomeFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if(Provider.of<TabModel>(context).tab == TabMenu.todo) {
      return FloatingActionButton(
        onPressed: () => Application.router.navigateTo(context, '/asd'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      );
    }
    return Container();
  }
}
