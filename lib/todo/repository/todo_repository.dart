import 'package:flutter_todo/common/network/domain/page_request.dart';
import 'package:flutter_todo/todo/domain/todo.dart';

abstract class TodoRepository {
  Future<int> count();

  Future<List<Todo>> get(PageRequest pageRequest);

  Future<List<Todo>> getAll();

  Future<Todo> insert(Todo entity);

  Future<Todo> update(Todo entity);

  delete(int idx);

}