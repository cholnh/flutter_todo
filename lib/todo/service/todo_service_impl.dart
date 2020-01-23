import 'package:flutter_todo/todo/domain/todo_dto.dart';
import 'package:flutter_todo/todo/repository/todo_repository.dart';
import 'package:flutter_todo/todo/service/todo_service.dart';

class TodoServiceImpl implements TodoService{

  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  final TodoRepository todoRepository;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  TodoServiceImpl({this.todoRepository});
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  @override
  Future<bool> delete(TodoDto todo) async {
    return todoRepository.delete(todo.toEntity());
  }

  @override
  Future<bool> update(TodoDto todo) async {
    return todoRepository.update(todo.toEntity());
  }

  @override
  Future<bool> insert(TodoDto todo) async {
    return todoRepository.update(todo.toEntity());
  }

  @override
  Future<List<TodoDto>> getAll() async {
    return TodoDto.fromEntities(await todoRepository.getAll());
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

}