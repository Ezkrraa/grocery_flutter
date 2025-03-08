sealed class AccountCreationResult {}

class SuccessResult extends AccountCreationResult {
  SuccessResult();
}

class FailureResult extends AccountCreationResult {
  FailureResult({required this.reason});
  final String reason;
}

bool isSuccess(AccountCreationResult result) {
  return switch (result) {
    SuccessResult() => true,
    FailureResult() => false,
  };
}
