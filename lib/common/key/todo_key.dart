import 'package:flutter/widgets.dart';

class TodoKeys {

  // Home
  static final homePage = Key('__homePage__');
  static final homeFab = Key('__homeFab__');

  // Demo
  static final demoPage = (String id) => Key('__demoPage_${id}__');
}