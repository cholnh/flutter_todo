import 'package:flutter/material.dart';
import 'package:flutter_todo/common/i18n/messages.dart';
import 'package:flutter_todo/common/route/config/config.dart';

class NotFoundPage extends StatelessWidget {
  NotFoundPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(Messages.notFoundMsg, style: TextStyle(fontSize: 26)),
              Padding(padding: EdgeInsets.only(bottom: 20)),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text(Messages.notFoundHomeBtn),
                    color: Theme.of(context).accentColor,
                    onPressed: () => Application.router.navigateTo(context, '/'),
                  ),
                  RaisedButton(
                    child: Text(Messages.notFoundBackBtn),
                    onPressed: () => Application.router.pop(context),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
