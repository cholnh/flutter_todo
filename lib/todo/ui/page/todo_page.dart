import 'package:flutter/material.dart';
import 'package:flutter_todo/common/key/key.dart';
import 'package:flutter_todo/todo/provider/provider.dart';
import 'package:flutter_todo/todo/ui/widget/todo_bottom_loader.dart';
import 'package:flutter_todo/todo/ui/widget/todo_list_item.dart';
import 'package:provider/provider.dart';

class TodoPage extends StatefulWidget {

  TodoPage({Key key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TodoModel _todoProvider = Provider.of<TodoModel>(context);
    return ListView.separated(
      key: TodoKeys.todoListView,
      itemBuilder: (context, index) {
        return index >= _todoProvider.todos.length
            ? BottomLoader()
            : TodoListItem(
                todo: _todoProvider.todos[index],
                onCheckboxChanged: (isUnChecked) {
                  _todoProvider.toggle(_todoProvider.todos[index].idx);
                });
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: _todoProvider.hasReachedMax
          ? _todoProvider.todos.length
          : _todoProvider.todos.length + 1,
      controller: _scrollController,
    );

  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      Provider.of<TodoModel>(context, listen: false).fetch();
    }
  }
}
