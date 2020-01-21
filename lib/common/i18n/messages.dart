import 'package:intl/intl.dart';

class Messages {

  /* !! method name 과 'name' property 는 일치 해야 함. !! */


  // common
  static String get appName => Intl.message('Todo List',
      name: 'appName'
  );

  // not found
  static String get notFoundMsg => Intl.message('UNKNOWN PAGE',
      name: 'notFoundMsg'
  );

  static String get notFoundBackBtn => Intl.message('back',
      name: 'notFoundBackBtn'
  );

  static String get notFoundHomeBtn => Intl.message('home',
      name: 'notFoundHomeBtn'
  );

}