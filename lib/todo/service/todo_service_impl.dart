import 'package:flutter_todo/common/network/domain/page_request.dart';
import 'package:flutter_todo/todo/domain/todo.dart';
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
  Future<int> count() async {
    return todoRepository.count();
  }

  @override
  Future<List<TodoDto>> get(PageRequest pageRequest) async {
    return TodoDto.fromEntities(await todoRepository.get(pageRequest));
  }

  @override
  Future<List<TodoDto>> getAll() async
    => TodoDto.fromEntities(await todoRepository.getAll());

  @override
  Future<TodoDto> update(TodoDto todo) async
    => TodoDto.fromEntity(await todoRepository.update(todo.toEntity()));

  @override
  Future<TodoDto> insert(TodoDto todo) async
    => TodoDto.fromEntity(await todoRepository.insert(todo.toEntity()));

  @override
  delete(int idx) async
    => await todoRepository.delete(idx);
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

}