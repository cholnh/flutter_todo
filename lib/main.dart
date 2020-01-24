import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todo/common/di/injector_register.dart';
import 'package:flutter_todo/common/i18n/i18n.dart';
import 'package:flutter_todo/common/router/app_router.dart';
import 'package:flutter_todo/splash/ui/splash_page.dart';
import 'package:flutter_todo/tab/provider/tab_model.dart';
import 'package:flutter_todo/todo/provider/todo_model.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';

void main() {
  InjectorRegister.register();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter router = Injector.appInstance.getDependency<AppRouter>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoModel()),
        ChangeNotifierProvider(create: (_) => TabModel()),

      ],
      child: MaterialApp(
        title: '${Messages.appName}',
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        darkTheme: ThemeData.dark(),
        home: SplashPage(),
        localizationsDelegates: [
          AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [Locale("en"), Locale("ko")],
        onGenerateRoute: router.generator,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
