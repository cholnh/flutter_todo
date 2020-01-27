import 'package:flutter_todo/common/network/domain/page_request.dart';
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
  Future<int> count() async
    => await networkService.get(url: '/todos/size');

  @override
  Future<List<Todo>> get(PageRequest pageRequest) async {
    var res = await networkService.get(url: '/todos?page=${pageRequest.page}&size=${pageRequest.size}');

    List<Todo> entities = [];
    res.forEach((map) => entities.add(Todo.fromJson(map)));
    return entities;
  }

  @override
  Future<List<Todo>> getAll() async {
    var res = await networkService.get(url: '/todos');

    List<Todo> entities = [];
    res.forEach((map) => entities.add(Todo.fromJson(map)));
    return entities;
  }

  @override
  Future<Todo> insert(Todo entity) async
    => Todo.fromJson(await networkService.post(url: '/todos', jsonData: entity.toJson()));

  @override
  Future<Todo> update(Todo entity) async
    => Todo.fromJson(await networkService.put(url: '/todos', jsonData: entity.toJson()));

  @override
  delete(int idx) async
    => await networkService.delete(url: '/todos/$idx');
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}