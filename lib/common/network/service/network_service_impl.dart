import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/common/network/domain/token.dart';
import 'package:flutter_todo/common/network/domain/user.dart';
import 'package:flutter_todo/common/network/domain/user_dto.dart';
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
    Token _token = await oauthTokenRepository
      .loadToken()
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
  Future<UserDto> signIn({
    @required String username,
    @required String password
  }) async {
    Token _token = await oauthTokenRepository
      .issueLoginToken(username: username, password: password)
      .catchError((err) {});

    if(_token != null) {
      _token
        ..saveToDisk()
        ..saveToDioHeader();
      return UserDto.fromEntity(User.fromJson(await resourceRepository.get(url: '/user/myInfo')));
    } else {
      throw OauthNetworkException(OauthExceptionType.badCredentials);
    }
  }

  @override
  signOut() {

  }

  @override
  signUp() {

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