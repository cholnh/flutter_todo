import 'package:fluro/fluro.dart';
import 'package:flutter_todo/common/route/handler/handler.dart' as h;

class Routes {
  static void configureRoutes(Router router) {

    // home
    router.define("/",
      handler: h.homeHandler,
      transitionType: TransitionType.material);

    // demo
    router.define("/demo/:id",
      handler: h.homeHandler,
      transitionType: TransitionType.material);

    // default
    router.notFoundHandler = h.defaultHandler;
  }
}