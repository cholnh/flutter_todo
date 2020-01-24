enum OauthExceptionType { networkError, serverMaintenance, serverClosed }

class OauthNetworkException implements Exception {
  OauthExceptionType type;
  OauthNetworkException(this.type);
}