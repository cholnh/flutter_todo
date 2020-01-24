import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class NetworkService {
  initialize({
    Function networkErrorHandler
  });
  get({
    @required String url,
    Locale locale
  });
  post({
    @required String url,
    Locale locale,
    FormData formData
  });
}