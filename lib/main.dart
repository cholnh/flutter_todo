import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_todo/common/i18n/i18n.dart';
import 'package:provider/provider.dart';
import 'todo/ui/ui.dart';
import 'todo/provider/provider.dart';
import 'common/route/route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '${Messages.appName}',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (_) => Counter(),
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
