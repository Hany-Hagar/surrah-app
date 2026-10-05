abstract class Failure {
  final String message;
  const Failure(this.message);
}

class LocalAuthFailure extends Failure {
  LocalAuthFailure({required String message}) : super(message);
}
