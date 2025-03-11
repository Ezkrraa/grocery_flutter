sealed class RequestResult<T> {}

class RequestSuccess<T> implements RequestResult<T> {
  final T result;
  RequestSuccess({required this.result});
  @override
  String toString() {
    return result.toString();
  }
}

class RequestError<T> implements RequestResult<T> {
  final String error;
  RequestError({required this.error});

  String errorType() => 'Generic Error';
  @override
  String toString() {
    return error == '' ? errorType() : error;
  }
}

class RequestErrorUnauthorized<T> extends RequestError<T> {
  RequestErrorUnauthorized(String error) : super(error: error);

  @override
  String errorType() => 'Unauthorized Error';
}

class RequestErrorConflict<T> extends RequestError<T> {
  RequestErrorConflict(String error) : super(error: error);

  @override
  String errorType() => 'Conflict Error';
}

class RequestErrorNotFound<T> extends RequestError<T> {
  RequestErrorNotFound(String error) : super(error: error);

  @override
  String errorType() => 'NotFound Error';
}

class RequestErrorBadRequest<T> extends RequestError<T> {
  RequestErrorBadRequest(String error) : super(error: error);

  @override
  String errorType() => 'BadRequest Error';
}

class RequestErrorConnectionError<T> extends RequestError<T> {
  RequestErrorConnectionError(String error) : super(error: error);

  @override
  String errorType() => 'Connection Error';
}
