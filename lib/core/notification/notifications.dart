import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:todo_app/core/models/todo_model.dart';
import 'notification_utilities.dart';

Future<void> createReminderNotification(
    {required DateTime date, required String name, required Todo todo}) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'scheduled_channel',
      title: 'Its Time ${Emojis.time_alarm_clock + Emojis.time_hourglass_done}',
      body:
          'Hi ${name.split(" ")[0]}, times up you have to ${todo.title} now!!!',
      notificationLayout: NotificationLayout.Default,
      payload: {'todo-id': todo.id!},
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      )
    ],
    schedule: NotificationCalendar.fromDate(date: date),
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}
