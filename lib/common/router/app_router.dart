import 'package:fluro/fluro.dart';
import 'package:flutter_todo/todo/ui/page/home_page.dart';
import 'package:flutter_todo/todo/ui/page/not_found_page.dart';

class AppRouter extends Router {
  void configureRoutes() {

    /// A HomePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/",
      handler:  Handler(handlerFunc: (context, params) {
        return HomePage();
      }),
      transitionType: TransitionType.material);


    /// A NotFoundPage router path.
    ///
    /// When an unknown path is called, Returns the page specified in the handler.
    super.notFoundHandler =
      Handler(handlerFunc: (context, params) {
        return NotFoundPage();
    });
  }
}