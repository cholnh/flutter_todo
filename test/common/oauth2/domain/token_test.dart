import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/common/oauth2/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../test.dart';

class TokenTest implements Testable {

  @override
  run() {
    setUp(() async {
    });

    tearDown(() async {
    });

    test('Token Test - saveToDisk(), loadFromDisk()', () async {
      // Given
      Token token1 = Token(
          accessToken: 'acctoken1234',
          tokenType: 'type',
          expiresIn: 123,
          scope: 'scope',
          refreshToken: 'retoken1234',
          tokenMode: TokenMode.LOGIN);
      Token token2;

      // When
      SharedPreferences.setMockInitialValues({});
      await token1.saveToDisk();
      token2 = await Token.loadFromDisk();

      // Then
      expect(token1.accessToken, equals(token2.accessToken));
      expect(token1.tokenType, equals(token2.tokenType));
      expect(token1.expiresIn, equals(token2.expiresIn));
      expect(token1.scope, equals(token2.scope));
      expect(token1.refreshToken, equals(token2.refreshToken));
      expect(token1.tokenMode, equals(token2.tokenMode));
    });
  }
}