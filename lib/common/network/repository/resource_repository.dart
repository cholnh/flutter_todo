import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_todo/common/network/dio/dio_core.dart';
import 'package:flutter_todo/common/network/repository/authorization_repository.dart';

class ResourceRepository {

  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  final OauthTokenRepository oauthTokenRepository;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  ResourceRepository({this.oauthTokenRepository});
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  get({
    @required String url,
    Locale locale,
  }) async {
    Options options = Options(headers: {
      'Accept-Language': locale == null ? 'ko' : locale.languageCode,
    });

    var res = await DioCore().resource.get(url, options: options)
      .catchError((err) async {
        await resourceErrorHandler(err);
        return await DioCore().resource.get(url, options: options);
    });

    if(res != null && res.statusCode == HttpStatus.ok) {
      return res.data;
    }
    return null;
  }

  post({
    @required String url,
    Locale locale,
    FormData formData
  }) async {
    Options options = Options(headers: {
      'Accept-Language': locale == null ? 'ko' : locale.languageCode,
    });

    var res = await DioCore().resource.post(
        url,
        options: options,
        data: formData)
      .catchError((err) async {
        await resourceErrorHandler(err);
        return await DioCore().resource.post(
            url,
            options: options,
            data: formData);
    });

    if(res != null && res.statusCode == 200) {
      return res.data;
    }
    return null;
  }

  resourceErrorHandler(err) async {
    switch((err as DioError).response.statusCode) {
      case HttpStatus.unauthorized:
        await oauthTokenRepository.loadToken()
          ..saveToDioHeader()
          ..saveToDisk();
        break;
    }
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}