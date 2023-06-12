class Todos {
  int? userId,id;
  String? todo;
  bool? checkBox;

  Todos({
    required this.userId,
    required this.id,
    required this.todo,
    required this.checkBox,
  });

  factory Todos.formJson(Map<String, dynamic> json) {
    return Todos(
      userId:json['userId'],
      id: json['id'],
      todo: json['title'],
      checkBox: json['completed'],
    );
  }
}