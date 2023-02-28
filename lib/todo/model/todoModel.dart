class TodoModel {
  final String id;

  ///고유아이디 순서로 사용 x
  final String todo;
  final bool isCheck;

  const TodoModel({
    required this.id,
    required this.todo,
    required this.isCheck,
  });

  TodoModel.json(Map<String, dynamic> json)
      : id = json['id'],
        todo = json['todo'],
        isCheck = json['isCheck'];

  TodoModel copy() =>
      TodoModel(id: this.id, todo: this.todo, isCheck: this.isCheck);
}
