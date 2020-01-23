import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo/common/network/dio/dio_core.dart';
import 'package:flutter_todo/common/network/domain/token.dart';
import 'package:flutter_todo/common/network/repository/authorization_repository.dart';
import 'package:flutter_todo/common/network/repository/resource_repository.dart';
import 'package:injector/injector.dart';

import '../../../test.dart';

class ResourceRepositoryTest implements Testable {

  OauthTokenRepository _oauthTokenRepository;
  ResourceRepository _resourceRepository;

  ResourceRepositoryTest() {
    Injector injector = Injector.appInstance;
    _oauthTokenRepository = injector.getDependency<OauthTokenRepository>();
    _resourceRepository = injector.getDependency<ResourceRepository>();
  }

  @override
  run() {
    DioCore dio;

    setUp(() async {
      dio = DioCore(); // singleton instance access
      dio.initialize();
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
      token = await _oauthTokenRepository.issueGuestToken();
      key = 'Authorization';
      val = 'Bearer '+token.accessToken;
      dio.addResourceHeader({key: val});
      res = await _resourceRepository.get(url: url);

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
      dio.initialize();

      // When
      token = await _oauthTokenRepository.loadToken()
        ..saveToDioHeader()
        ..saveToDisk();
      res = await _resourceRepository.get(url: url)
        .catchError((err) async {
          await _resourceRepository.resourceErrorHandler(err);
          return await _resourceRepository.get(url: '/');
      });

      // Then
      expect(token.accessToken != null, true);
      expect(res, equals('this is home'));
    });
  }
}