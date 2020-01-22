import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todo/common/i18n/i18n.dart';
import 'package:flutter_todo/common/oauth2/exception/oauth_exception.dart';
import 'package:flutter_todo/common/oauth2/repository/authorization_repository.dart';
import 'package:flutter_todo/common/oauth2/repository/repository.dart';
import 'package:flutter_todo/tab/provider/tab_model.dart';
import 'package:flutter_todo/todo/ui/page/home_page.dart';
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
            // Todo: error handling
            print('networkError');
          } else if(type == OauthExceptionType.serverMaintenance) {
            // Todo: error handling
            print('serverMaintenance');
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
        primarySwatch: Colors.deepOrange,
      ),
      darkTheme: ThemeData.dark(),
      home:
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => TodoModel()),
          ChangeNotifierProvider(create: (_) => TabModel()),

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
