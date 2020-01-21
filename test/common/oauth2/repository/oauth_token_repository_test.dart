import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/common/oauth2/domain/domain.dart';
import 'package:flutter_todo/common/oauth2/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test.dart';

class OauthTokenRepositoryTest implements Testable {

  @override
  run() {
    test('Oauth Token Repository Test - issueGuestToken()', () async {
      // Given
      Token guestToken;
      bool isValidToken;

      // When
      guestToken = await OauthTokenRepository.issueGuestToken();
      isValidToken = await OauthTokenRepository.isValid(accessToken: guestToken.accessToken);

      // Then
      expect(guestToken.accessToken != null, true);
      expect(guestToken.refreshToken == null, true);
      expect(guestToken.tokenMode, equals(TokenMode.GUEST));
      expect(isValidToken, true);
    });

    test('Oauth Token Repository Test - issueLoginToken()', () async {
      // Given
      Token loginToken;
      bool isValidToken;

      // When
      loginToken = await OauthTokenRepository.issueLoginToken(username: 'admin', password: '1234');
      isValidToken = await OauthTokenRepository.isValid(accessToken: loginToken.accessToken);

      // Then
      expect(loginToken.accessToken != null, true);
      expect(loginToken.refreshToken != null, true);
      expect(loginToken.tokenMode, equals(TokenMode.LOGIN));
      expect(isValidToken, true);
    });

    test('Oauth Token Repository Test - issueLoginToken()', () async {
      // Given
      Token loginToken;
      Token refreshedToken;

      // When
      loginToken = await OauthTokenRepository.issueLoginToken(username: 'admin', password: '1234');
      refreshedToken = await OauthTokenRepository.refreshLoginToken(refreshToken: loginToken.refreshToken);

      // Then
      expect(refreshedToken.accessToken != null, true);
      expect(refreshedToken.refreshToken != null, true);
      expect(refreshedToken.accessToken != loginToken.accessToken, true);
      expect(refreshedToken.refreshToken, equals(loginToken.refreshToken));
      expect(refreshedToken.tokenMode, equals(TokenMode.LOGIN));
      expect(await OauthTokenRepository.isValid(accessToken: refreshedToken.accessToken), true);
      expect(await OauthTokenRepository.isValid(accessToken: refreshedToken.refreshToken), false);
    });

    test('Oauth Token Repository Test - isValid()', () async {
      // Given
      Token normalToken;
      bool isValidToken, isInValidToken;

      // When
      normalToken = await OauthTokenRepository.issueLoginToken(username: 'admin', password: '1234');
      isValidToken = await OauthTokenRepository.isValid(accessToken: normalToken.accessToken);
      isInValidToken = await OauthTokenRepository.isValid(accessToken: 'this-is-abnormal-token');

      // Then
      expect(isValidToken, true);
      expect(isInValidToken, false);
    });

    test('Oauth Token Repository Test - getToken()', () async {
      // Given
      SharedPreferences.setMockInitialValues({});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Token token;
      bool isValidToken;

      // When
      token = await OauthTokenRepository.loadToken()
        ..saveToDioHeader()  // dio http header 추가
        ..saveToDisk();      // shared preference 저장

      isValidToken = await OauthTokenRepository.isValid(accessToken: token.accessToken);

      // Then
      expect(token.accessToken != null, true);
      expect(isValidToken, true);
      expect(token.tokenMode == TokenMode.GUEST ? 'guest' : 'login', equals(prefs.get('__oauth_tokenMode__')));
      expect(token.accessToken, equals(prefs.get('__oauth_accessToken__')));
      expect(token.tokenType, equals(prefs.get('__oauth_tokenType__')));
      expect(token.expiresIn, equals(prefs.get('__oauth_expiresIn__')));
      expect(token.scope, equals(prefs.get('__oauth_scope__')));
      expect(token.refreshToken, equals(prefs.get('__oauth_refreshToken__')));
    });

    test('Oauth Token Repository Test - serverHealthCheck()', () async {
      // Given
      String serverHealth;

      // When
      serverHealth = await OauthTokenRepository.serverHealthCheck();

      // Then
      expect(serverHealth, equals('UP'));
    });
  }
}