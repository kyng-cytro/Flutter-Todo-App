import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/data/functions/todo_state.dart';
import 'package:todo_app/core/models/todo_model.dart';
import 'package:todo_app/general/pages/home.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    List<Todo> todos = List<Todo>.from(
        Provider.of<TodoState>(context).todos.where((e) => e.state != true));
    List<Todo> completed = List<Todo>.from(
        Provider.of<TodoState>(context).todos.where((e) => e.state == true));
    return Column(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: 0),
          physics: NeverScrollableScrollPhysics(),
          reverse: true,
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (context, index) {
            Todo todo = todos[index];
            return Dismissible(
              key: Key(todo.id!),
              confirmDismiss: (DismissDirection dismissDirection) async {
                if (dismissDirection == DismissDirection.startToEnd) {
                  await edittodo(todo);
                  return false;
                } else {
                  return true;
                }
              },
              onDismissed: (direction) async {
                if (direction == DismissDirection.endToStart) {
                  TodoState ts = Provider.of<TodoState>(context, listen: false);
                  var res = await ts.deletetodo(todo);
                  if (res == true) {
                    setState(() {
                      todos =
                          Provider.of<TodoState>(context, listen: false).todos;
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Todo Deleted')));
                  } else {
                    setState(() {
                      todos =
                          Provider.of<TodoState>(context, listen: false).todos;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Error Please Try Again")));
                  }
                }
              },
              background: Container(
                color: Colors.orange,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              child: ListTile(
                onTap: () async {
                  Todo updated = Todo(
                      id: todo.id,
                      title: todo.title,
                      userId: todo.userId,
                      category: todo.category,
                      color: todo.color,
                      createdAt: todo.createdAt,
                      updatedAt: DateTime.now(),
                      state: !todo.state,
                      remind: todo.remind);
                  TodoState ts = Provider.of<TodoState>(context, listen: false);
                  var res = await ts.update(updated);
                  if (res = true) {
                    setState(() {
                      todos =
                          Provider.of<TodoState>(context, listen: false).todos;
                    });
                  } else {
                    final snackBar = SnackBar(content: Text(res.message));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                leading: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 13,
                  child: CircleAvatar(
                    backgroundColor: Color(0xffededed),
                    radius: 10,
                  ),
                ),
                title: Text(
                  todo.title,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    wordSpacing: 1,
                    letterSpacing: .5,
                    decoration: null,
                  ),
                ),
                trailing: (todo.remind)
                    ? Icon(
                        Icons.trip_origin,
                        color: Colors.teal,
                        size: 15,
                      )
                    : null,
              ),
            );
          },
        ),
        SizedBox(height: 2),
        completed.isEmpty
            ? Container()
            : Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  title: Text(
                    "Completed ${completed.length}",
                    style: TextStyle(
                      fontSize: 14.0,
                      letterSpacing: 1.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  initiallyExpanded: true,
                  trailing: Text(""),
                  children: completed
                      .map<Widget>((todo) => Dismissible(
                            key: Key(todo.id!),
                            confirmDismiss:
                                (DismissDirection dismissDirection) async {
                              if (dismissDirection ==
                                  DismissDirection.startToEnd) {
                                await edittodo(todo);
                                return false;
                              } else {
                                return true;
                              }
                            },
                            onDismissed: (direction) async {
                              if (direction == DismissDirection.endToStart) {
                                TodoState ts = Provider.of<TodoState>(context,
                                    listen: false);
                                var res = await ts.deletetodo(todo);
                                if (res == true) {
                                  setState(() {
                                    todos = Provider.of<TodoState>(context,
                                            listen: false)
                                        .todos;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Todo Deleted')));
                                } else {
                                  setState(() {
                                    todos = Provider.of<TodoState>(context,
                                            listen: false)
                                        .todos;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("Error Please Try Again")));
                                }
                              }
                            },
                            background: Container(
                              color: Colors.orange,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.red,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            child: ListTile(
                              onTap: () async {
                                Todo updated = Todo(
                                    id: todo.id,
                                    title: todo.title,
                                    userId: todo.userId,
                                    category: todo.category,
                                    color: todo.color,
                                    createdAt: todo.createdAt,
                                    updatedAt: DateTime.now(),
                                    state: !todo.state,
                                    remind: todo.remind);
                                TodoState ts = Provider.of<TodoState>(context,
                                    listen: false);
                                var res = await ts.update(updated);
                                if (res = true) {
                                  setState(() {
                                    todos = Provider.of<TodoState>(context,
                                            listen: false)
                                        .todos;
                                  });
                                } else {
                                  final snackBar =
                                      SnackBar(content: Text(res.message));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                }
                              },
                              leading: CircleAvatar(
                                radius: 13,
                                backgroundColor: Color(0xff5aa787),
                                child: Icon(
                                  Icons.assignment_turned_in_outlined,
                                  size: 17,
                                ),
                              ),
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black87,
                                  wordSpacing: 1,
                                  letterSpacing: .5,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Color(0xff5aa787),
                                ),
                              ),
                              trailing: (todo.remind)
                                  ? Icon(
                                      Icons.trip_origin,
                                      color: Color(0xff5aa787),
                                      size: 15,
                                    )
                                  : null,
                            ),
                          ))
                      .toList(),
                ),
              ),
      ],
    );
  }
}
