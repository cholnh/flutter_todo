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
    Options options = Options(headers: {
      'Accept-Language': locale == null ? 'ko' : locale.languageCode,
    });

    var res = await DioCore().resource.get(url, options: options)
      .catchError((err) async {
        await ResourceRepository.resourceErrorHandler(err);
        return await DioCore().resource.get(url, options: options);
    });

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
    Options options = Options(headers: {
      'Accept-Language': locale == null ? 'ko' : locale.languageCode,
    });

    var res = await DioCore().resource.post(url, options: options, data: formData)
      .catchError((err) async {
        await ResourceRepository.resourceErrorHandler(err);
        return await DioCore().resource.post(url, options: options, data: formData);
    });

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