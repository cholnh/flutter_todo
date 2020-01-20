import 'package:fluro/fluro.dart';
import 'package:flutter_todo/todo/ui/ui.dart';
import 'package:flutter/material.dart';

var homeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HomePage();
});

var defaultHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return HomePage();
});