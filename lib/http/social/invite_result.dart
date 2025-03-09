sealed class RequestResult {}

class RequestSuccess implements RequestResult {}

class RequestError extends RequestResult {
  final String error;
  RequestError({required this.error});

  String errorType() => 'Generic';
}

class RequestErrorUnauthorized extends RequestError {
  RequestErrorUnauthorized(String error) : super(error: error);

  @override
  String errorType() => 'Unauthorized';
}

class RequestErrorConflict extends RequestError {
  RequestErrorConflict(String error) : super(error: error);

  @override
  String errorType() => 'Conflict';
}

class RequestErrorNotFound extends RequestError {
  RequestErrorNotFound(String error) : super(error: error);

  @override
  String errorType() => 'NotFound';
}

class RequestErrorBadRequest extends RequestError {
  RequestErrorBadRequest(String error) : super(error: error);

  @override
  String errorType() => 'BadRequest';
}

class RequestErrorConnectionError extends RequestError {
  RequestErrorConnectionError(String error) : super(error: error);

  @override
  String errorType() => 'ConnectionError';
}
