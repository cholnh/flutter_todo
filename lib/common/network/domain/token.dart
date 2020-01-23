import 'package:flutter/foundation.dart';
import 'package:flutter_todo/common/network/dio/dio_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_todo/common/key/shared_preference_key.dart' as s;

enum TokenMode { GUEST, LOGIN }

class Token {


  //━━ class variables ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  String accessToken;
  String tokenType;
  int expiresIn;
  String scope;
  String refreshToken;
  TokenMode tokenMode;
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ constructor ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  Token({
    @required this.accessToken,
    @required this.tokenType,
    @required this.expiresIn,
    @required this.scope,
    @required this.refreshToken,
    @required this.tokenMode});

  Token.fromJson(Map<String, dynamic> json) :
    tokenMode = TokenMode.GUEST,
    accessToken = json['access_token'],
    tokenType = json['token_type'],
    expiresIn = json['expires_in'],
    scope = json['scope'],
    refreshToken = json['refresh_token'];
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛


  //━━ actions ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
  static Future<Token> loadFromDisk() async {
    try {
      String accessToken, tokenType, scope, refreshToken;
      int expiresIn;
      TokenMode tokenMode;

      SharedPreferences prefs = await SharedPreferences.getInstance();

      String strTokenMode = prefs.get(s.tokenMode);
      assert(strTokenMode != null);

      if(strTokenMode == 'guest') {
        tokenMode = TokenMode.GUEST;
      } else if(strTokenMode == 'login') {
        tokenMode = TokenMode.LOGIN;
        refreshToken = prefs.get(s.refreshToken);
        assert(refreshToken != null);
      } else {
        assert(false);
      }

      accessToken = prefs.get(s.accessToken);
      assert(accessToken != null);

      tokenType = prefs.get(s.tokenType);
      assert(tokenType != null);

      expiresIn = prefs.get(s.expiresIn);
      assert(expiresIn != null);

      scope = prefs.get(s.scope);
      assert(scope != null);

      return Token(
          accessToken: accessToken,
          tokenType: tokenType,
          expiresIn: expiresIn,
          scope: scope,
          refreshToken: refreshToken,
          tokenMode: tokenMode);
    } catch (e) {}
    return null;
  }

  saveToDisk() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(tokenMode == TokenMode.GUEST) {
      prefs.setString(s.tokenMode, 'guest');
    } else if(tokenMode == TokenMode.LOGIN) {
      prefs.setString(s.tokenMode, 'login');
      prefs.setString(s.refreshToken, refreshToken);
    }

    prefs.setString(s.accessToken, accessToken);
    prefs.setString(s.tokenType, tokenType);
    prefs.setInt(s.expiresIn, expiresIn);
    prefs.setString(s.scope, scope);
    return this;
  }

  saveToDioHeader() {
    DioCore().addResourceHeader({
      'Authorization':'Bearer ' + accessToken
    }); // interceptor header 추가
    return this;
  }

  @override
  String toString() {
    return 'Token{accessToken: $accessToken, tokenType: $tokenType, expiresIn: $expiresIn, scope: $scope, refreshToken: $refreshToken, tokenMode: $tokenMode}';
  }
  //━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
}