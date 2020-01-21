import 'package:flutter/foundation.dart';
import 'package:flutter_todo/tab/domain/tab_menu.dart';

class TabProvider with ChangeNotifier {
  TabMenu tab;

  TabProvider() {
    tab = TabMenu.todo;
  }

  change(TabMenu to) {
    tab = to;
    notifyListeners();
  }
}