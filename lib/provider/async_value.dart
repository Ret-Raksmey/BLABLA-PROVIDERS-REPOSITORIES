enum AsyncValueState {
  loading,
  success,
  error,
}

class AsyncValue<T> {
  final T? data;
  final Object? error;
  final AsyncValueState state;

  const AsyncValue._({
    this.data,
    this.error,
    required this.state,
  });

  factory AsyncValue.loading() {
    return AsyncValue._(state: AsyncValueState.loading);
  }

  factory AsyncValue.success(T data) {
    return AsyncValue._(
      data: data,
      state: AsyncValueState.success,
    );
  }

  factory AsyncValue.error(Object error) {
    return AsyncValue._(
      error: error,
      state: AsyncValueState.error,
    );
  }

  bool get isLoading => state == AsyncValueState.loading;
  bool get isSuccess => state == AsyncValueState.success;
  bool get isError => state == AsyncValueState.error;

  R when<R>({
    required R Function() loading,
    required R Function(T data) success,
    required R Function(Object error) error,
  }) {
    switch (state) {
      case AsyncValueState.loading:
        return loading();
      case AsyncValueState.success:
        return success(data as T);
      case AsyncValueState.error:
        return error(this.error!);
    }
  }
}