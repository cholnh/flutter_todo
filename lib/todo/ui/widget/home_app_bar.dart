import 'package:flutter/material.dart';
import 'package:flutter_todo/common/i18n/messages.dart';
import 'package:flutter_todo/common/network/domain/sign_state.dart';
import 'package:flutter_todo/common/network/provider/user_model.dart';
import 'package:provider/provider.dart';

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
      Consumer<UserModel>(
        builder: (_, model, child) {
          if(model.signState == SignState.signedIn) {
            return Container(
              padding: EdgeInsets.all(5),
              child: Text('${model.userInfo.nickname}'),
            );
          }
          return Container();
        },
      ),
      IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () => print('refresh!'),
      ),
    ],
  );
}
