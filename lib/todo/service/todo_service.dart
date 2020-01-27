import 'package:flutter_todo/common/network/domain/page_request.dart';
import 'package:flutter_todo/todo/domain/todo_dto.dart';

abstract class TodoService {
  Future<int> count();

  Future<List<TodoDto>> get(PageRequest pageRequest);

  Future<List<TodoDto>> getAll();

  Future<TodoDto> insert(TodoDto todo);

  Future<TodoDto> update(TodoDto todo);

  delete(int idx);

}