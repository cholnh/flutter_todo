import 'package:dio/dio.dart';
import 'package:flutter_todo/common/network/constant/endpoint.dart';

class DioCore {

  Dio oauth;
  Dio resource;

  static final DioCore _singleton = DioCore._internal();

  factory DioCore() {
    return _singleton;
  }

  DioCore._internal() {
    initialize();
  }

  initialize() {
    final BaseOptions options = BaseOptions(
      baseUrl: Endpoint.serverDomain,
      connectTimeout: Endpoint.connectTimeout,
      receiveTimeout: Endpoint.receiveTimeout,
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