// import 'dart:async';
// import 'package:serve_to_be_free/cubits/user/cubit.dart';
// import 'package:serve_to_be_free/triggers/trigger.dart' show Trigger;
// 
// todo: notifiations should be pushed to clients on change instead
// class NotificationsTrigger extends Trigger {
  // static const Duration _period = Duration(minutes: 5);
// 
  // void init(UserCubit userCubit, NotificationsCubit notificationsCubit) {
    // when(
        // thereIsA: Stream<int>.periodic(_period),
        // doThis: (_) async {
          // final userId = userCubit.state.id;
          // if (userId != '') {
            // notificationsCubit.load(userId);
          // }
        // });
  // }
// }
// 
// instead just put the periodic in the cubit itself
// 
// void callPeriodically({
  // required UserCubit userCubit,
  // Duration period = const Duration(minutes: 5),
// }) {
  // this.stream = Stream<int>.periodic(period, (_) {
    // final userId = userCubit.state.id;
    // if (userId != '') {
      // load(userId);
    // }
  // });
// }
