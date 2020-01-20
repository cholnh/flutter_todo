import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/common/dio/dio_core.dart';
import 'package:flutter_todo/common/oauth2/domain/domain.dart';
import 'package:flutter_todo/common/oauth2/repository/repository.dart';

import '../../../test.dart';

class ResourceRepositoryTest implements Testable {

  @override
  run() {
    DioCore dio;

    setUp(() async {
      dio = DioCore(); // singleton instance access
    });

    tearDown(() async {

    });

    test('Token Test - get()', () async {
      // Given
      final String url = '/';
      Token token;
      var res;
      String key, val;

      // When
      token = await OauthTokenRepository.issueGuestToken();
      key = 'Authorization';
      val = 'Bearer '+token.accessToken;
      dio.addResourceHeader({key: val});
      res = await ResourceRepository.get(url: url);

      // Then
      expect(token.accessToken != null, true);
      expect(res, equals('this is home'));

      // header 에 직접 삽입되는 것이 아니라, interceptor 를 통해 append 됨.
      expect(dio.resource.options.headers.containsKey(key), false);
      expect(dio.resource.options.headers.containsValue(val), false);
    });

    test('Token Test - get() with oauthTokenRepository.getToken()', () async {
      // Given
      final String url = '/';
      Token token;
      var res;

      // When
      token = await OauthTokenRepository.loadToken();
      res = await ResourceRepository.get(url: url);

      // Then
      expect(token.accessToken != null, true);
      expect(res, equals('this is home'));
    });
  }
}