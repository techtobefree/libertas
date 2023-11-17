import 'dart:async';

class CustomException implements Exception {
  CustomException([this._prefix, this._message]);
  final String? _prefix;
  final String? _message;

  @override
  String toString() =>
      <String?>[_prefix, _message].whereType<String>().join(': ');
}

class AlreadyListening extends CustomException {
  AlreadyListening([String? message]) : super('Already listening', message);
}

typedef Listener<T> = void Function(T event);
typedef Check<T> = bool Function(T event);

abstract class Trigger {
  Trigger();
  final Map<String, StreamSubscription<dynamic>> listeners =
      <String, StreamSubscription<dynamic>>{};

  Future<void> when<T>({
    required Stream<T> thereIsA,
    Check<T>? andIf,
    required Listener<T> doThis,
    String? key,
    bool autoDeinit = false,
  }) async {
    key ??= determineKey(thereIsA);
    if (autoDeinit) {
      await deinitKey(key);
    }
    if (!listeners.keys.contains(key)) {
      listeners[key] = thereIsA
          .listen(andIf == null ? doThis : (T v) => andIf(v) ? doThis : () {});
    } else {
      throw AlreadyListening('$key already listening');
    }
  }

  String determineKey<T>(Stream<T> stream) => stream.hashCode.toString();

  Future<void> deinit() async {
    for (final StreamSubscription<dynamic> listener in listeners.values) {
      await listener.cancel();
    }
    listeners.clear();
  }

  Future<void> deinitKeys(List<String> keys) async {
    for (final String listener in keys) {
      await listeners[listener]?.cancel();
      listeners.remove(listener);
    }
  }

  Future<void> deinitKey(String key) async => deinitKeys(<String>[key]);
}
