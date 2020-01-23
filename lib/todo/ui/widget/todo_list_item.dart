import 'package:flutter_todo/common/key/key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/todo/domain/todo_dto.dart';

class TodoListItem extends StatelessWidget {
  final TodoDto todo;
  final ValueChanged<bool> onCheckboxChanged;

  const TodoListItem({
    Key key,
    @required this.todo,
    @required this.onCheckboxChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: TodoKeys.todoItem(todo.idx.toString()),
      leading: Checkbox(
        key: TodoKeys.todoItemCheckbox(todo.idx.toString()),
        value: todo.completed,
        onChanged: onCheckboxChanged,
      ),
      title: Text(todo.title),
      isThreeLine: true,
      subtitle: Text(todo.contents),
      dense: true,
    );
  }
}