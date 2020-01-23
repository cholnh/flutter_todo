import 'package:flutter/material.dart';
import 'package:flutter_todo/tab/domain/tab_menu.dart';
import 'package:flutter_todo/tab/provider/tab_model.dart';
import 'package:flutter_todo/tab/ui/widget/home_bottom_navigation_bar.dart';
import 'package:flutter_todo/todo/provider/todo_model.dart';
import 'package:flutter_todo/todo/ui/page/more_page.dart';
import 'package:flutter_todo/todo/ui/page/stat_page.dart';
import 'package:flutter_todo/todo/ui/page/todo_page.dart';
import 'package:flutter_todo/todo/ui/widget/home_app_bar.dart';
import 'package:flutter_todo/todo/ui/widget/home_fab.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: TabMenu.values.length);
    _tabController.addListener(() {
      Provider.of<TabModel>(context, listen: false).change(
        TabMenu.values[_tabController.index]
      );
    });
    Provider.of<TodoModel>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false), // 뒤로가기 방지
      child: DefaultTabController(
        length: TabMenu.values.length,
        child:  Scaffold(
          appBar: HomeAppBar(),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              TodoPage(),
              StatPage(),
              MorePage()
            ],
          ),
          floatingActionButton: HomeFab(),
          bottomNavigationBar: HomeBottomNavigationBar(tabController: _tabController)
        )
      )
    );
  }
}
