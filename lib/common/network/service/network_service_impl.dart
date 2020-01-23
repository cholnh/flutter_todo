import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  void initialize({
    Function networkErrorHandler,
    Function maintenanceErrorHandler}) async {
      await oauthTokenRepository.loadToken()
        .catchError((err) {
          OauthExceptionType type = (err as OauthNetworkException).type;
          if(type == OauthExceptionType.networkError) {
            networkErrorHandler();
          } else if(type == OauthExceptionType.serverMaintenance) {
            maintenanceErrorHandler();
          }
      })
        ..saveToDioHeader()
        ..saveToDisk();
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