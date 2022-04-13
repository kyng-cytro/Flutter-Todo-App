import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/core/auth/functions/auth_state.dart';
import 'package:todo_app/core/data/functions/todo_state.dart';
import 'package:todo_app/core/data/widgets/todo_list.dart';
import 'package:todo_app/core/notification/notification_utilities.dart';
import 'package:todo_app/core/models/todo_model.dart';
import 'package:todo_app/core/notification/notifications.dart';
import 'package:todo_app/general/widgets/header_widget.dart';
import 'package:todo_app/general/widgets/search_widget.dart';

final _toShow = new ValueNotifier(false);
TextEditingController _title = TextEditingController();
TextEditingController _search = TextEditingController();
bool _isediting = false;
DateTime? _remider;
late Todo _update;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _getUser();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        requestPermission(context);
      }
    });

    AwesomeNotifications().actionStream.listen((notification) async {
      if (notification.payload!['todo-id'] != null) {
        TodoState ts = Provider.of<TodoState>(context, listen: false);
        var res = await ts.completetodo(notification.payload!['todo-id']!);
        if (res == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Todo Updated'),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(res.message),
            ),
          );
        }
      }
    });
  }

  _getUser() async {
    try {
      Provider.of<AuthState>(context, listen: false).user;
    } catch (e) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("loggedin", false);
      Navigator.pushReplacementNamed(context, "/intro");
    }
  }

  @override
  void dispose() {
    AwesomeNotifications().actionSink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthState _state = Provider.of<AuthState>(context, listen: false);
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: _toShow,
        builder: (context, value, child) {
          return Stack(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    FocusScope.of(context).unfocus();
                    _toShow.value = false;
                    _remider = null;
                    _isediting = false;
                    _title.clear();
                  });
                },
                child: DraggableHome(
                  title: Text(
                    "TODO'S",
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: .5,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () async {
                        var res = await _state.logout();
                        if (res == true) {
                          cancelScheduledNotifications();
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setBool("loggedin", false);
                          final snackBar = SnackBar(
                            content: Text("Logged Out"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.popAndPushNamed(context, "/intro");
                        }
                      },
                      icon: Icon(Icons.logout_outlined),
                      color: Color(0xffbbc2d8),
                    ),
                  ],
                  headerWidget: headerWidget(context, _state),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _toShow.value = true;
                      });
                    },
                    child: Icon(Icons.add),
                  ),
                  backgroundColor: Color(0xffededed),
                  body: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: SearchInput(controller: _search),
                    ),
                    TodoList(),
                  ],
                ),
              ),
              AnimatedPositioned(
                curve: Curves.fastLinearToSlowEaseIn,
                duration: Duration(milliseconds: 1000),
                left: 0,
                bottom:
                    _toShow.value ? -20 : -(MediaQuery.of(context).size.height),
                child: MenuWidget(
                  controller: _title,
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class MenuWidget extends StatefulWidget {
  final TextEditingController controller;

  MenuWidget({required this.controller});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ValueListenableBuilder<bool>(
      valueListenable: _toShow,
      builder: (context, value, child) {
        return ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          child: Container(
            color: Color(0xff354341),
            width: width,
            height: height * (24.72 / 100),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextField(
                    onChanged: (change) {
                      setState(() {});
                    },
                    controller: widget.controller,
                    maxLines: null,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 20),
                      border: InputBorder.none,
                      hintText: "Enter Task Title...",
                      hintStyle: TextStyle(
                        color: Colors.white60,
                        fontSize: 18,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFBC7C7C7),
                              border: Border.all(
                                  color: Color(0xFFBC7C7C7), width: 2),
                              borderRadius: BorderRadius.circular(100)),
                          child: GestureDetector(
                            onTap: () async {
                              final initialDate = DateTime.now();
                              final initialTime = TimeOfDay(
                                  hour: DateTime.now().hour,
                                  minute: DateTime.now().minute + 1);
                              final newDate = await showDatePicker(
                                  context: context,
                                  initialDate: _remider ?? initialDate,
                                  firstDate: initialDate,
                                  lastDate: DateTime(DateTime.now().year + 5));
                              final newTime = await showTimePicker(
                                  context: context,
                                  initialTime: _remider != null
                                      ? TimeOfDay(
                                          hour: _remider!.hour,
                                          minute: _remider!.minute)
                                      : initialTime);
                              if (newDate != null && newTime != null) {
                                setState(() {
                                  _remider = DateTime(
                                    newDate.year,
                                    newDate.month,
                                    newDate.day,
                                    newTime.hour,
                                    newTime.minute,
                                  );
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.alarm,
                                    color: Colors.black,
                                    size: 20,
                                  ),
                                  SizedBox(width: 4.0),
                                  Text(
                                    (_remider != null)
                                        ? "${DateFormat("dd/MM").format(_remider!)} ${(_remider!.hour.toString().length > 1) ? _remider!.hour : "0" + _remider!.minute.toString()}:${(_remider!.minute.toString().length > 1) ? _remider!.minute : "0" + _remider!.minute.toString()}"
                                        : "Set reminder",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 3),
                                  (_remider != null)
                                      ? Text(
                                          "|",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(width: 3),
                                  (_remider != null)
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _remider = null;
                                            });
                                          },
                                          child: Icon(
                                            Icons.cancel_outlined,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        OutlinedButton(
                          child: Text((_isediting) ? "Update" : "Done",
                              style: TextStyle(
                                color: (widget.controller.text.isEmpty)
                                    ? Color(0xffbc7c7c7)
                                    : Color(0xff5aa787),
                                fontSize: 16,
                              )),
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                            style: BorderStyle.none,
                          )),
                          onPressed: () async {
                            if (widget.controller.text.isNotEmpty) {
                              if (_isediting) {
                                Todo todo = Todo(
                                    id: _update.id,
                                    title: widget.controller.text,
                                    userId: _update.userId,
                                    category: _update.category,
                                    color: _update.color,
                                    createdAt: _update.createdAt,
                                    updatedAt: DateTime.now(),
                                    state: false,
                                    remind: (_remider != null) ? true : false);
                                TodoState ts = Provider.of<TodoState>(context,
                                    listen: false);
                                var res = await ts.update(todo);
                                if (res == true) {
                                  if (_remider != null) {
                                    await createReminderNotification(
                                        date: _remider!,
                                        todo: todo,
                                        name: Provider.of<AuthState>(context,
                                                listen: false)
                                            .user
                                            .name);
                                  }
                                  FocusScope.of(context).unfocus();
                                  _toShow.value = false;
                                  _remider = null;
                                  _isediting = false;
                                  widget.controller.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Todo Updated')));
                                } else {
                                  FocusScope.of(context).unfocus();
                                  _toShow.value = false;
                                  _remider = null;
                                  _isediting = false;
                                  widget.controller.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(res.message)));
                                }
                              } else {
                                Todo todo = Todo(
                                  title: widget.controller.text,
                                  userId: Provider.of<AuthState>(context,
                                          listen: false)
                                      .user
                                      .id,
                                  state: false,
                                  remind: (_remider != null) ? true : false,
                                  category: "all",
                                  color: "BC7C7C7",
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                );
                                TodoState ts = Provider.of<TodoState>(context,
                                    listen: false);
                                var res = await ts.addtodo(todo);

                                if (res.id != null) {
                                  if (_remider != null) {
                                    await createReminderNotification(
                                        date: _remider!,
                                        todo: res,
                                        name: Provider.of<AuthState>(context,
                                                listen: false)
                                            .user
                                            .name);
                                  }
                                  FocusScope.of(context).unfocus();
                                  _toShow.value = false;
                                  _remider = null;
                                  _isediting = false;
                                  widget.controller.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Todo Added')));
                                } else {
                                  FocusScope.of(context).unfocus();
                                  _toShow.value = false;
                                  _isediting = false;
                                  widget.controller.clear();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(res.message)));
                                }
                              }
                            } else {
                              FocusScope.of(context).unfocus();
                              _toShow.value = false;
                              _remider = null;
                              _isediting = false;
                              widget.controller.clear();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Todo titles can not be empty')));
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

edittodo(Todo todo) async {
  _isediting = true;
  _update = todo;
  _remider = null;
  _toShow.value = true;
  _title.text = todo.title;
}
