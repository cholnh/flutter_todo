import 'package:flutter/material.dart';
import 'package:flutter_todo/common/key/key.dart';

class HomeBottomNavigationBar extends StatelessWidget {

  final TabController tabController;

  HomeBottomNavigationBar({
    Key key,
    @required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: TodoKeys.tabSafeArea,
      child: TabBar(
        controller: tabController,
        labelColor: Colors.deepOrange,
        indicatorColor: Colors.deepOrange,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelColor: Colors.grey,
        tabs: <Tab>[
          Tab(icon: Icon(Icons.list)),
          Tab(icon: Icon(Icons.show_chart)),
          Tab(icon: Icon(Icons.more_horiz))
        ],
      ),
    );
  }
}