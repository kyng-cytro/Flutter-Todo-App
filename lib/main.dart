import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/general/providers.dart';
import 'package:todo_app/general/functions/route_gen.dart';
import 'general/widgets/restart_widget.dart';
import 'general/widgets/splash_screen.dart';

void main() {
  AwesomeNotifications().initialize('resource://drawable/appicon', [
    NotificationChannel(
      channelKey: 'scheduled_channel',
      channelName: 'Scheduled Notifications',
      defaultColor: Color(0xff5aa787),
      locked: true,
      importance: NotificationImportance.High,
    ),
  ]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return RestartWidget(
      child: MultiProvider(
        providers: providers,
        child: MaterialApp(
          title: 'Todo App',
          theme: ThemeData(
            primaryColor: Color(0xff354341),
            fontFamily: "Nunito",
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Color(0xff5aa787)),
          ),
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
          onGenerateRoute: RouteGen.generateRoute,
        ),
      ),
    );
  }
}
