import 'package:fluro/fluro.dart';
import 'package:flutter_todo/tab/provider/tab_model.dart';
import 'package:flutter_todo/todo/provider/provider.dart';
import 'package:flutter_todo/todo/ui/page/home_page.dart';
import 'package:flutter_todo/todo/ui/page/not_found_page.dart';
import 'package:provider/provider.dart';

class Routes {
  static void configureRoutes(Router router) {

    // todo
    router.define("/",
      handler:  Handler(handlerFunc: (context, params) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => TodoModel()),
            ChangeNotifierProvider(create: (_) => TabModel()),

          ],
          child: HomePage(),
        );
      }),
      transitionType: TransitionType.material);


    // default
    router.notFoundHandler =
      Handler(handlerFunc: (context, params) {
        return NotFoundPage();
    });
  }
}