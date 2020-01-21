import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_todo/common/dio/dio_core.dart';
import 'package:flutter_todo/common/oauth2/repository/authorization_repository.dart';

class ResourceRepository {

  static get({
    @required String url,
    Locale locale,
  }) async {
    var res = await DioCore().resource.get(url,
      options: Options(headers: {
        'Accept-Language': locale == null ? 'ko' : locale.languageCode,
      }),
    );

    if(res != null && res.statusCode == HttpStatus.ok) {
      return res.data;
    }
    return null;
  }

  static post({
    @required String url,
    Locale locale,
    FormData formData
  }) async {
    var res = await DioCore().resource.post(url,
        options: Options(headers: {
          'Accept-Language': locale == null ? 'ko' : locale.languageCode,
        }),
        data: formData
    );

    if(res != null && res.statusCode == 200) {
      return res.data;
    }
    return null;
  }

  static resourceErrorHandler(err) async {
    switch((err as DioError).response.statusCode) {
      case HttpStatus.unauthorized:
        await OauthTokenRepository.loadToken()
          ..saveToDioHeader()
          ..saveToDisk();
        break;
    }
  }
}