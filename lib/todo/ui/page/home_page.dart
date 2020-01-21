import 'package:flutter/material.dart';
import 'package:flutter_todo/tab/provider/tab_provider.dart';
import 'package:flutter_todo/tab/tab.dart';
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
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false), // 뒤로가기 방지
      child: Consumer<TabProvider>(
        builder: (context, curTab, child) {
          return DefaultTabController(
            length: TabMenu.values.length,
            child: Scaffold(
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
              bottomNavigationBar: HomeBottomNavigationBar(tabController: _tabController,),
            ),
          );
        }
      ),
    );
  }
}
