import 'package:flutter_todo/todo/domain/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getAll();

  Future<bool> insert(Todo entity);

  Future<bool> update(Todo entity);

  Future<bool> delete(Todo entity);

}