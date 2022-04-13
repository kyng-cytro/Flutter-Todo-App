class Todo {
  String? id;
  String? collection;
  Permissions? permissions;
  String title;
  String userId;
  String category;
  String color;
  DateTime createdAt;
  DateTime updatedAt;
  bool state;
  bool remind;

  Todo({
    this.id,
    this.collection,
    this.permissions,
    required this.title,
    required this.userId,
    required this.category,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.remind,
  });

  Todo.fromJson(Map<String, dynamic> json)
      : id = json['\$id'],
        collection = json['\$collection'],
        permissions = json['\$permissions'] != null
            ? new Permissions.fromJson(json['\$permissions'])
            : null,
        title = json['title'],
        category = json['category'],
        color = json['color'],
        userId = json['user_id'],
        createdAt = DateTime.fromMillisecondsSinceEpoch(json['created_at']),
        updatedAt = DateTime.fromMillisecondsSinceEpoch(json['updated_at']),
        state = json['state'],
        remind = json['remind'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['category'] = this.category;
    data['color'] = this.color;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt.millisecondsSinceEpoch;
    data['updated_at'] = this.updatedAt.millisecondsSinceEpoch;
    data['state'] = this.state;
    data['remind'] = this.remind;
    return data;
  }
}

class Permissions {
  List<String> read;
  List<String> write;

  Permissions({required this.read, required this.write});

  Permissions.fromJson(Map<String, dynamic> json)
      : read = json['read'].cast<String>(),
        write = json['write'].cast<String>();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['read'] = this.read;
    data['write'] = this.write;
    return data;
  }
}
