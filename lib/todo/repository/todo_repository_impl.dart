import 'dart:convert';

import 'package:flutter_todo/common/network/service/network_service.dart';
import 'package:flutter_todo/todo/domain/todo.dart';
import 'package:flutter_todo/todo/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  final NetworkService networkService;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  TodoRepositoryImpl({this.networkService});
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  @override
  Future<List<Todo>> getAll() async {
    var res = await networkService.get(url: '/todos');

    List<Todo> entities = [];
    json.decode(res)
        .forEach((map) => entities.add(Todo.fromJson(map)));
    return res;
  }

  @override
  Future<bool> insert(Todo entity) {

  }

  @override
  Future<bool> update(Todo entity) {

  }

  @override
  Future<bool> delete(Todo entity) {

  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}