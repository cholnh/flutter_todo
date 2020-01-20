import 'package:dio/dio.dart';
import 'package:flutter_todo/common/config/config.dart' as g;

class DioCore {

  Dio oauth;
  Dio resource;

  static final DioCore _singleton = DioCore._internal();

  factory DioCore() {
    return _singleton;
  }

  DioCore._internal() {
    final BaseOptions options = BaseOptions(
      baseUrl: g.serverDomain,
      connectTimeout: g.connectTimeout,
      receiveTimeout: g.receiveTimeout,
    );

    oauth = Dio(options);
    resource = Dio(options);
  }

  addResourceHeader(Map<String, dynamic> header) {
    resource.interceptors.add(InterceptorsWrapper(
      onRequest:(RequestOptions options) async {
        options.headers.addAll(header);
        return options;
      },
      onResponse:(Response response) async {
        return response;
      },
      onError: (DioError e) async {
        return  e;
      }
    ));
  }

}