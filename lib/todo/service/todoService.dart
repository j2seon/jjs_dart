import 'dart:async';

import 'package:jjs/todo/model/todoModel.dart';

///상태를 제외한 모든 로직 분리
/// 로직 = 알고리즘
/// 레포지토리
/// 상태 - 서비스 - 레포지토리
/// + interface....
/// class - implements
/// abstract class - implements //// extends :단계를 압축해서.

///1:다의 관계에서 필요한가?????
abstract class TodoService {
  TodoModel readDummy() {
    final dumy = {
      'id': '0',
      'todo': 'myTodo',
      'isCheck': false,
    };
    return TodoModel.json(dumy);
  }

  //퓨쳐냐 아니냐만 반환하게끔.
  FutureOr<TodoModel> read();

  //FutureOr말고
  //누군가가 Future로 이미 되어있다.
  Future<TodoModel> add({required String id, required String todo, required bool isCheck});
}

class TodoServiceJs extends TodoService {
  //레포지토리만 가져다가 쓴다.
  @override
  FutureOr<TodoModel> read() {
    // return super.readDummy();
    // return Future<TodoModel>(super.readDummy);
    throw '테스트용 서비스 입니다 readDummy를 쓰세요';
  }

  TodoModel readDummy() {
    final dumy = {
      'id': '0',
      'todo': 'myTodo',
      'isCheck': false,
    };
    return TodoModel.json(dumy);
  }

  // Future을 줘보자 -> future를 반환하거나 add 를 async 더나을것 같다는 생각만하자
  Future<TodoModel> add({required String id, required String todo, required bool isCheck}) =>
      Future<TodoModel>(() => TodoModel(id: id, todo: todo, isCheck: isCheck)); // 서버에 접속을 할거면 이거자체를 async 하면된다!!!

  // 이렇게 해도 같은 기능이다.
  // Future<TodoModel> add({required String id, required String todo, required bool isCheck}) async =>
  //     TodoModel(id: id, todo: todo, isCheck: isCheck);

}

// class TodoServiceJs2 extends TodoService {
//   @override //쓰기 싫으면 재정의해
//   TodoModel readDummy() {
//     throw '쓰지마';
//   }
// }
