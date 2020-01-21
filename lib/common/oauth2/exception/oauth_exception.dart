enum OauthExceptionType { networkError, serverMaintenance }

class OauthNetworkException implements Exception {
  OauthExceptionType type;
  OauthNetworkException(this.type);
}