class Failure {
  final String error;
  final String reason;
  const Failure(this.error, this.reason);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure()
      : super(
          'TIMEOUT_ERROR',
          'Your request timed out, check your internet connection and try again.',
        );
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure()
      : super('AUTHENTICATION_ERROR',
            'The details you provided us did not belong to an account.');
}

class ServerConnectionFailure extends Failure {
  const ServerConnectionFailure()
      : super(
          'SERVER_CONNECTIVITY_ERROR',
          'We were unable to connect to Gemini\'s sever, please try again.',
        );
}

class InternalServerFailure extends Failure {
  const InternalServerFailure()
      : super(
          'INTERNAL_SERVER_ERROR',
          'There was a problem on our end, please give us some time to fix it.',
        );
}

class GeminiErrorResponseFailure extends Failure {
  const GeminiErrorResponseFailure(String error, String reason)
      : super(error, reason);
}

class UnknownFailure extends Failure {
  const UnknownFailure()
      : super(
          'UNKNOWN_FAILURE',
          'There was an error on the device, please contact us about this.',
        );
}
