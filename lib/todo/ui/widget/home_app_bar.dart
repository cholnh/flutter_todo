import 'package:flutter/material.dart';
import 'package:flutter_todo/common/i18n/messages.dart';

class HomeAppBar extends AppBar {
  HomeAppBar() : super(
    centerTitle: false,
    automaticallyImplyLeading: false,
    title :InkWell(
      child: Row(
        children: <Widget>[
          //Icon(Icons.calendar_today),
          Padding(padding: EdgeInsets.only(right: 5)),
          Text(Messages.appName, style: TextStyle(fontSize: 20))
        ],
      ),
      onTap: () => print('tab!'),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () => print('refresh!'),
      ),
    ],
  );
}
