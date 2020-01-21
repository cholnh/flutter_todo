import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todo/common/i18n/i18n.dart';
import 'package:flutter_todo/common/oauth2/exception/oauth_exception.dart';
import 'package:flutter_todo/common/oauth2/repository/authorization_repository.dart';
import 'package:flutter_todo/common/oauth2/repository/repository.dart';
import 'package:flutter_todo/tab/provider/tab_provider.dart';
import 'package:provider/provider.dart';
import 'todo/ui/ui.dart';
import 'todo/provider/provider.dart';
import 'common/route/route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp() { // initialize
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    Future(() async {
      await OauthTokenRepository.loadToken()
        .catchError((err) {
          OauthExceptionType type = (err as OauthNetworkException).type;
          if(type == OauthExceptionType.networkError) {
            print('networkError');
            // Todo: error handling
          } else if(type == OauthExceptionType.serverMaintenance) {
            print('serverMaintenance');
            // Todo: error handling
          }
      })
        ..saveToDioHeader()
        ..saveToDisk();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${Messages.appName}',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CounterProvider()),
          ChangeNotifierProvider(create: (_) => TabProvider()),

        ],
        child: HomePage(),
      ),
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale("en"), Locale("ko")],
      onGenerateRoute: Application.router.generator,
      debugShowCheckedModeBanner: false,
    );
  }
}
