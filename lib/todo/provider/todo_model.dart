import 'package:flutter/material.dart';
import 'package:flutter_todo/common/network/domain/page_request.dart';
import 'package:flutter_todo/todo/domain/todo_dto.dart';
import 'package:flutter_todo/todo/service/todo_service.dart';
import 'package:injector/injector.dart';

class TodoModel with ChangeNotifier {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  List<TodoDto> todos = List();
  bool hasReachedMax = false;
  TodoService _todoService;

  int curPage = 0;
  int size = 10;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  TodoModel() {
    _todoService = Injector.appInstance.getDependency<TodoService>();
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  void fetch() async {
    if(hasReachedMax) return;

    List<TodoDto> fetched = await _todoService.get(PageRequest(
        page: curPage++,
        size: size));
    todos.addAll(fetched);

    int listCount = await _todoService.count();
    hasReachedMax = listCount <= todos.length;
    notifyListeners();
  }

  void toggle(idx) async {
    for(TodoDto todo in todos) {
      if(todo.idx == idx) {
        todo.completed = !todo.completed;
        await _todoService.update(todo);
        notifyListeners();
        break;
      }
    }
  }

  List<TodoDto> getCompleted() {
    return todos.where((todo) => todo.completed).toList();
  }

  List<TodoDto> getInCompleted() {
    return todos.where((todo) => !todo.completed).toList();
  }

  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}