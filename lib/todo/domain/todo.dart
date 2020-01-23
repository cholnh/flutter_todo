class Todo {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  final int idx;
  final String username;
  final String title;
  final String contents;
  final bool completed;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  const Todo({
    this.idx,
    this.username,
    this.title,
    this.contents,
    this.completed});
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      idx: json['idx'],
      username: json['username'],
      title: json['title'],
      contents: json['contents'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idx': idx,
      'username': username,
      'title': title,
      'contents': contents,
      'completed': completed,
    };
  }

  @override
  String toString() {
    return 'Todo{idx: $idx, username: $username, title: $title, contents: $contents, completed: $completed}';
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}