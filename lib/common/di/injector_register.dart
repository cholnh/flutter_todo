import 'package:fluro/fluro.dart';
import 'package:flutter_todo/common/network/repository/authorization_repository.dart';
import 'package:flutter_todo/common/network/repository/resource_repository.dart';
import 'package:flutter_todo/common/network/service/network_service.dart';
import 'package:flutter_todo/common/network/service/network_service_impl.dart';
import 'package:flutter_todo/common/router/app_router.dart';
import 'package:flutter_todo/todo/provider/todo_model.dart';
import 'package:flutter_todo/todo/repository/todo_repository_impl.dart';
import 'package:flutter_todo/todo/repository/todo_repository.dart';
import 'package:flutter_todo/todo/service/todo_service.dart';
import 'package:flutter_todo/todo/service/todo_service_impl.dart';
import 'package:injector/injector.dart';

class InjectorRegister {

  static register() {
    Injector.appInstance

      /// A singleton OauthTokenRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
      ..registerSingleton<Router>
        ((_) => Router())


      /// A singleton OauthTokenRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
      ..registerSingleton<AppRouter>
        ((injector) {
          AppRouter router = AppRouter();
          router.configureRoutes();
          return router;
        })


      /// A singleton OauthTokenRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
      ..registerSingleton<OauthTokenRepository>
        ((_) => OauthTokenRepository())


      /// A singleton ResourceRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
      ..registerSingleton<ResourceRepository>
        ((injector) => ResourceRepository(
          oauthTokenRepository: injector.getDependency<OauthTokenRepository>()))


      /// A singleton NetworkService provider.
      ///
      /// Calling it multiple times will return the same instance.
      ..registerDependency<NetworkService>
        ((injector) => NetworkServiceImpl(
          oauthTokenRepository: injector.getDependency<OauthTokenRepository>(),
          resourceRepository: injector.getDependency<ResourceRepository>()))


      /// A singleton TodoRepository provider.
      ///
      /// Calling it multiple times will return the same instance.
      ..registerDependency<TodoRepository>
        ((injector) => TodoRepositoryImpl(
        networkService: injector.getDependency<NetworkService>()))


      /// A singleton TodoService provider.
      ///
      /// Calling it multiple times will return the same instance.
      ..registerDependency<TodoService>
      ((injector) => TodoServiceImpl(
          todoRepository: injector.getDependency<TodoRepository>()));


  }
}