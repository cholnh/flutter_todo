import 'package:flutter/material.dart';
import 'package:flutter_todo/common/router/app_router.dart';
import 'package:flutter_todo/tab/domain/tab_menu.dart';
import 'package:flutter_todo/tab/provider/tab_model.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

class HomeFab extends StatelessWidget {

  final AppRouter router = Injector.appInstance.getDependency<AppRouter>();

  @override
  Widget build(BuildContext context) {
    if(Provider.of<TabModel>(context).tab == TabMenu.todo) {
      return FloatingActionButton(
        onPressed: () => router.navigateTo(context, '/asd'),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      );
    }
    return Container();
  }


}
