import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class NetworkService {
  void initialize({
    Function networkErrorHandler,
    Function maintenanceErrorHandler
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