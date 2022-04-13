import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_app/core/auth/functions/auth_state.dart';
import 'package:todo_app/core/data/functions/todo_state.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => AuthState(),
    lazy: false,
  ),
  ChangeNotifierProvider(
    create: (context) => TodoState(),
    lazy: false,
  ),
];
