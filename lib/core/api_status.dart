class Success {
  Object response;
  Success({
    required this.response,
  });
}

class Failure {
  String errorResponse;
  Failure({
    required this.errorResponse,
  });
}
