sealed class SendInviteResult {}

class SendInviteSuccess implements SendInviteResult {}

class SendInviteError extends SendInviteResult {
  final String error;
  SendInviteError({required this.error});
}

class SendInviteUnauthorized extends SendInviteError {
  SendInviteUnauthorized(String error) : super(error: error);
}

class SendInviteConflict extends SendInviteError {
  SendInviteConflict(String error) : super(error: error);
}

class SendInviteNotFound extends SendInviteError {
  SendInviteNotFound(String error) : super(error: error);
}

class SendInviteBadRequest extends SendInviteError {
  SendInviteBadRequest(String error) : super(error: error);
}

class SendInviteConnectionError extends SendInviteError {
  SendInviteConnectionError(String error) : super(error: error);
}
