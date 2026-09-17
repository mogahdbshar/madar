sealed class AppFailure {
  const AppFailure(this.message);
  final String message;
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure(super.message);
}
