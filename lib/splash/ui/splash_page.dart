import 'package:flutter/material.dart';
import 'package:flutter_todo/common/i18n/i18n.dart';
import 'package:flutter_todo/common/network/service/network_service.dart';
import 'package:flutter_todo/common/router/app_router.dart';
import 'package:injector/injector.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  final AppRouter router = Injector.appInstance.getDependency<AppRouter>();
  String imgSrc = 'assets/loading.gif';


  @override
  void initState() {
    super.initState();
    Future(() async {
      NetworkService _networkService
        = Injector.appInstance.getDependency<NetworkService>();
      await _networkService.initialize(
          networkErrorHandler: () =>
          router.navigateTo(context, '/error/Server Down'));

      changeImage(); // when success
    }).catchError((err) => print('[_SplashPageState.initState.Future error]: $err'));
  }

  void changeImage() {
    setState(() {
      imgSrc = 'assets/logo3.gif';
    });
    Future.delayed(Duration(milliseconds: 2500), () => router.navigateTo(context, '/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Image(
              image: AssetImage(imgSrc),
              width: 150,
              height: 150,
            ),
            alignment: Alignment.center,
          ),
          Container(
            child: Text(
              Messages.companyName,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            margin: EdgeInsets.only(bottom: 50),
            alignment: Alignment.bottomCenter,
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
