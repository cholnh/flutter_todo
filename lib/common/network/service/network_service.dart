import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/common/network/domain/user_dto.dart';

abstract class NetworkService {
  initialize({
    Function networkErrorHandler
  });
  Future<UserDto> signIn({String username, String password});
  signOut();
  signUp();
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