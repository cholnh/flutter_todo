import 'package:fluro/fluro.dart';
import 'package:flutter_todo/common/ui/page/error_page.dart';
import 'package:flutter_todo/todo/ui/page/home_page.dart';
import 'package:flutter_todo/common/ui/page/not_found_page.dart';

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


    /// A HomePage router path.
    ///
    /// Returns the page specified in the handler.
    super.define("/error/:msg",
      handler:  Handler(handlerFunc: (context, params) {
        return ErrorPage(contents: params['msg'][0]);
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