import 'package:flutter_todo/todo/domain/todo_dto.dart';

abstract class TodoService {
  Future<List<TodoDto>> getAll();

  Future<bool> insert(TodoDto todo);

  Future<bool> update(TodoDto todo);

  Future<bool> delete(TodoDto todo);

}