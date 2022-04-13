import 'package:appwrite/appwrite.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/core/general/app_constants.dart';
import 'package:todo_app/core/models/todo_model.dart';

class TodoState extends ChangeNotifier {
  final String collectionId = "60fbd806c795f";
  Client client = Client();
  late Database db;
  late String _error;
  late List<Todo> _todos;
  late String _query;

  set query(String query) {
    _query = query;
    getTodos();
  }

  List<Todo> get todos => _todos;

  String get error => _error;

  TodoState() {
    _init();
  }
  _init() {
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId);
    db = Database(client);
    _todos = [];
    _query = "";
    getTodos();
  }

  Future<List<Todo>> getTodos() async {
    try {
      Response res = await db.listDocuments(
          collectionId: collectionId, orderField: "updated_at", search: _query);
      if (res.statusCode == 200) {
        _todos = List<Todo>.from(
            res.data["documents"].map((tr) => Todo.fromJson(tr)));
        notifyListeners();
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  addtodo(Todo todo) async {
    var update;
    try {
      Response res = await db.createDocument(
          collectionId: collectionId,
          data: todo.toJson(),
          read: ["user:${todo.userId}"],
          write: ["user:${todo.userId}"]);
      _todos.add(Todo.fromJson(res.data));
      update = Todo.fromJson(res.data);
      notifyListeners();
    } catch (e) {
      return e;
    }
    return update;
  }

  update(Todo todo) async {
    try {
      Response res = await db.updateDocument(
          collectionId: collectionId,
          documentId: todo.id!,
          data: todo.toJson(),
          read: ["user:${todo.userId}"],
          write: ["user:${todo.userId}"]);
      Todo updated = Todo.fromJson(res.data);
      _todos = List<Todo>.from(
          _todos.map((todo) => todo.id == updated.id ? updated : todo));
      notifyListeners();
    } catch (e) {
      return e;
    }
    return true;
  }

  deletetodo(Todo todo) async {
    try {
      await db.deleteDocument(collectionId: collectionId, documentId: todo.id!);
      _todos = List<Todo>.from(_todos.where((e) => e.id != todo.id));
      notifyListeners();
    } catch (e) {
      return e;
    }
    return true;
  }

  completetodo(String id) async {
    try {
      Response res =
          await db.getDocument(collectionId: collectionId, documentId: id);
      Todo todo = Todo.fromJson(res.data);
      Todo updated = Todo(
        id: todo.id,
        category: todo.category,
        color: todo.color,
        createdAt: todo.createdAt,
        updatedAt: DateTime.now(),
        title: todo.title,
        userId: todo.userId,
        remind: false,
        state: true,
      );
      await update(updated);
    } catch (e) {
      return e;
    }
    return true;
  }
}
