import 'package:fluro/fluro.dart';
import 'package:flutter_todo/todo/ui/page/home_page.dart';
import 'package:flutter_todo/todo/ui/page/not_found_page.dart';

class AppRouter extends Router {
  void configureRoutes() {

    // todo
    super.define("/",
      handler:  Handler(handlerFunc: (context, params) {
        return HomePage();
      }),
      transitionType: TransitionType.material);

    // default
    super.notFoundHandler =
      Handler(handlerFunc: (context, params) {
        return NotFoundPage();
    });
  }
}