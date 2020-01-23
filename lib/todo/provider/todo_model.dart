import 'package:flutter/material.dart';
import 'package:flutter_todo/todo/domain/todo_dto.dart';

class TodoModel with ChangeNotifier {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  List<TodoDto> todos = List();
  bool hasReachedMax = false;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  void fetch() async {
    if(hasReachedMax) return;
    todos.addAll(await _getData(0, 20));
    hasReachedMax = todos.length >= 100;
    notifyListeners();
  }

  void toggle(idx) {
    todos.forEach((todo) {
      if(todo.idx == idx) {
        todo.completed = !todo.completed;
      }
    });
    notifyListeners();
  }

  _getData(start, end) {
    if(hasReachedMax) return;
    if(start>=end) return null;
    List<TodoDto> list = List();
    int idx = todos.isEmpty
        ? 1
        : todos.last.idx + 1;
    for(var i=0; i<end-start; i++) {
      TodoDto dto = TodoDto(
          idx: idx,
          username: 'user'+idx.toString(),
          title: 'title'+idx.toString(),
          contents: 'contents'+idx.toString(),
          completed: false
      );
      list.add(dto);
      idx++;
    }
    return list;
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}