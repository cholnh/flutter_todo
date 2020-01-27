import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TodoKeys {

  // Home
  static final homePage = Key('__homePage__');

  static final homeFab = Key('__homeFab__');
  static final homeTab = Key('__homeTab__');
  // Demo
  static final demoPage = (String id) => Key('__demoPage_${id}__');
  // Tab
  static final tabSafeArea = Key('__tabSafeArea__');
  // Todo
  static final todoListView = Key('__todoListView__');
  static final todoItem = (String id) => Key('__todoItem_${id}__');
  static final todoItemCheckbox = (String id) => Key('__todoItemCheckbox_${id}__');
  // More
  static final loginForm = GlobalKey<FormState>();
}