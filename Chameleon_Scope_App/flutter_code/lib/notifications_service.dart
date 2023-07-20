import "dart:async";
import "dart:io";
import "package:notifications/notifications.dart";


class NotificationsService {
  Notifications? _notifications;
  StreamSubscription<NotificationEvent>? _subscription;

  void startListening(Function(NotificationEvent) onNotificationReceived) {
    _notifications = Notifications();
    try {
      _subscription = _notifications!.notificationStream!.listen(onNotificationReceived);
      print('Notification listening');
    } on NotificationException catch (exception) {
      print(exception);
    }
  }

  void stopListening() {
    _subscription?.cancel();
    print('Notification not listening');
  }
}
