import 'failure.dart';

class DataResponse<T> {
  final Failure? failure;
  final T? content;
  final bool isSuccessful;

  const DataResponse.failure(this.failure)
      : isSuccessful = false,
        content = null;
  const DataResponse.success(this.content)
      : isSuccessful = true,
        failure = null;
}
