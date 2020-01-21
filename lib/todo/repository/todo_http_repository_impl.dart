import 'dart:convert';

import 'package:flutter_todo/common/oauth2/repository/repository.dart';
import 'package:flutter_todo/todo/domain/domain.dart';
import 'package:flutter_todo/todo/repository/todo_repository.dart';

class TodoHttpRepositoryImpl implements TodoRepository {

  @override
  Future<List<Todo>> getAll() async {
    var res = await ResourceRepository.get(url: '/todos');

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

}