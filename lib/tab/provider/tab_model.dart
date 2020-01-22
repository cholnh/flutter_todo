import 'package:flutter/foundation.dart';
import 'package:flutter_todo/tab/domain/tab_menu.dart';

class TabModel with ChangeNotifier {
  TabMenu tab;

  TabModel() {
    tab = TabMenu.todo;
  }

  change(TabMenu to) {
    tab = to;
    notifyListeners();
  }
}