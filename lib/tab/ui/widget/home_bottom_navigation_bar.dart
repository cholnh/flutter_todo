import 'package:flutter/material.dart';
import 'package:flutter_todo/common/key/todo_key.dart';
import 'package:flutter_todo/tab/domain/tab_menu.dart';

class HomeBottomNavigationBar extends StatelessWidget {

  final TabMenu activeTab;
  final Function(TabMenu) onTabSelected;

  HomeBottomNavigationBar({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: TodoKeys.homeTab,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          title: Text('Todo'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart),
          title: Text('Stat'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          title: Text('more'),
        ),
      ],

      currentIndex: TabMenu.values.indexOf(activeTab),
      selectedItemColor: Colors.amber[800],
      onTap: (index) => onTabSelected(TabMenu.values[index]),
    );
  }
}