sealed class RequestResult<T> {}

class RequestSuccess<T> implements RequestResult<T> {
  final T result;
  RequestSuccess({required this.result});
}

class RequestError<T> implements RequestResult<T> {
  final String error;
  RequestError({required this.error});

  String errorType() => 'Generic';
}

class RequestErrorUnauthorized<T> extends RequestError<T> {
  RequestErrorUnauthorized(String error) : super(error: error);

  @override
  String errorType() => 'Unauthorized';
}

class RequestErrorConflict<T> extends RequestError<T> {
  RequestErrorConflict(String error) : super(error: error);

  @override
  String errorType() => 'Conflict';
}

class RequestErrorNotFound<T> extends RequestError<T> {
  RequestErrorNotFound(String error) : super(error: error);

  @override
  String errorType() => 'NotFound';
}

class RequestErrorBadRequest<T> extends RequestError<T> {
  RequestErrorBadRequest(String error) : super(error: error);

  @override
  String errorType() => 'BadRequest';
}

class RequestErrorConnectionError<T> extends RequestError<T> {
  RequestErrorConnectionError(String error) : super(error: error);

  @override
  String errorType() => 'ConnectionError';
}
