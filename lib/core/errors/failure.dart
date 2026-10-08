abstract class Failure {
  final String message;
  const Failure(this.message);
}

class LocalAuthFailure extends Failure {
  LocalAuthFailure({required String message}) : super(message);
}

class UpdateFailure extends Failure {
  UpdateFailure({required String message}) : super(message);
}

class ReportFailure extends Failure {
  ReportFailure({required String message}) : super(message);
}
