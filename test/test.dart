import 'common/oauth2/domain/token_test.dart';
import 'common/oauth2/repository/oauth_token_repository_test.dart';
import 'common/oauth2/repository/resource_repository_test.dart';

abstract class Testable {
  run();
}

void main() {
  List<Testable>.from([
    TokenTest(),
    OauthTokenRepositoryTest(),
    ResourceRepositoryTest(),
  ]).forEach((test) => test.run());
}