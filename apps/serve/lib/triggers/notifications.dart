import 'dart:async';
import 'package:serve_to_be_free/triggers/trigger.dart' show Trigger;

// todo: notifiations should be pushed to clients on change instead
class NotificationsTrigger extends Trigger {
  static const Duration _period = Duration(minutes: 5);

  void init(notificationsCubit) {
    when(
      thereIsA: Stream<dynamic>.periodic(_period),
      doThis: (_) async => notificationsCubit.load(),
    );
  }
}
