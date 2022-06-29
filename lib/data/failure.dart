class GeminiFailure {
  final String error;
  final String reason;
  const GeminiFailure(this.error, this.reason);
}

class GeminiTimeoutFailure extends GeminiFailure {
  const GeminiTimeoutFailure()
      : super(
          'TIMEOUT_ERROR',
          'Your request timed out, check your internet connection and try again.',
        );
}

class GeminiAuthenticationFailure extends GeminiFailure {
  const GeminiAuthenticationFailure()
      : super('AUTHENTICATION_ERROR', 'The details you provided us did not belong to an account.');
}

class GeminiServerConnectionFailure extends GeminiFailure {
  const GeminiServerConnectionFailure()
      : super(
          'SERVER_CONNECTIVITY_ERROR',
          'We were unable to connect to Gemini\'s sever, please try again.',
        );
}

class GeminiInternalServerFailure extends GeminiFailure {
  const GeminiInternalServerFailure()
      : super(
          'INTERNAL_SERVER_ERROR',
          'There was a problem on our end, please give us some time to fix it.',
        );
}

class GeminiErrorResponseFailure extends GeminiFailure {
  const GeminiErrorResponseFailure(String error, String reason) : super(error, reason);
}

class GeminiUnknownFailure extends GeminiFailure {
  const GeminiUnknownFailure()
      : super(
          'UNKNOWN_FAILURE',
          'There was an error on the device, please contact us about this.',
        );
}
