import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/common/network/domain/token.dart';
import 'package:flutter_todo/common/network/exception/oauth_exception.dart';
import 'package:flutter_todo/common/network/repository/authorization_repository.dart';
import 'package:flutter_todo/common/network/repository/resource_repository.dart';
import 'package:flutter_todo/common/network/service/network_service.dart';

class NetworkServiceImpl implements NetworkService {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  final OauthTokenRepository oauthTokenRepository;
  final ResourceRepository resourceRepository;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  NetworkServiceImpl({this.oauthTokenRepository, this.resourceRepository});
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  @override
  initialize({Function networkErrorHandler}) async {
      Token _token = await oauthTokenRepository.loadToken()
        .catchError((err) {
          if(err.error is SocketException) {
            networkErrorHandler();
          }
      });

      if(_token != null) {
        _token
          ..saveToDioHeader()
          ..saveToDisk();
      } else {
        throw OauthNetworkException(OauthExceptionType.networkError);
      }
  }

  @override
  get({
    @required String url,
    Locale locale
  }) => resourceRepository.get(url: null, locale: locale);


  @override
  post({
    @required String url,
    Locale locale,
    FormData formData
  }) => resourceRepository.post(url: null, locale: locale, formData: formData);
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}