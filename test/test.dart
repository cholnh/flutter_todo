import 'package:flutter_todo/common/di/injector_register.dart';

import 'common/network/domain/token_test.dart';
import 'common/network/repository/oauth_token_repository_test.dart';
import 'common/network/repository/resource_repository_test.dart';

abstract class Testable {
  run();
}

void main() {
  InjectorRegister.register();

  List<Testable>.from([
    TokenTest(),
    OauthTokenRepositoryTest(),
    ResourceRepositoryTest(),
  ]).forEach((test) => test.run());
}