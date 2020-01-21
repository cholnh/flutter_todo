import 'package:flutter/material.dart';
import 'package:flutter_todo/common/i18n/messages.dart';
import 'package:flutter_todo/tab/provider/tab_provider.dart';
import 'package:flutter_todo/tab/ui/widget/home_bottom_navigation_bar.dart';
import 'package:flutter_todo/todo/provider/provider.dart';
import 'package:flutter_todo/todo/ui/todo_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${Messages.appName}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home Page',
            ),
            Consumer<CounterProvider>(
                builder: (context, counter, child) {
                  return Text(
                    '${counter.value}',
                    style: Theme.of(context).textTheme.display1,
                  );
                }
            ),
            RaisedButton(
              child: Text('Todo'),
              onPressed: () => Navigator.push(context, new MaterialPageRoute(
                  builder: (context) => TodoPage()
              )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: Provider.of<CounterProvider>(context, listen: false).increase,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: Consumer<TabProvider>(
        builder: (context, homeTab, child) {
          return HomeBottomNavigationBar(
            activeTab: homeTab.tab,
            onTabSelected: (tab) => Provider.of<TabProvider>(context, listen: false).change(tab),
          );
        }
      ),
    );
  }
}
