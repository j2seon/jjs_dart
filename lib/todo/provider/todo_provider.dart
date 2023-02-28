import 'package:flutter/foundation.dart';

import '../model/todoModel.dart';
import '../service/todoService.dart';

//proxyprovider??? 프록시란? provider?
class TodoProvider with ChangeNotifier {

  TodoService _service = TodoServiceJs();

  TodoProvider(){
    Future(this._read); //일반함수가 다 끝나고 실행되니까.
  }

  //변수에 무슨짓을 못하게...final을 작성한다.
  final List<TodoModel> _todo = [];
  List<TodoModel> get todo => [...this._todo];

  //프로바이더가 만들어지만 쓸수있게 하고싶다.
  void _read(){

    // final dumy = {
    //   'id':'0',
    //   'todo':'myTodo',
    //   'isCheck': false,
    // };

    // this._todo.add(TodoModel.json(dumy));
    this._todo.add(_service.readDummy());
    this.notifyListeners();
  }

  // void read(){
  //   this._read();
  // }

  Future<TodoModel> add({required String todo, bool isCheck = false}) {

    // final TodoModel _todoItem = TodoModel( // 직접 객체를 넣어서 만들어줘야한다.
    //   id: _todo.toString(), //uuid
    //   todo: todo,
    //   isCheck: isCheck,
    // );
    // this._todo.add(_todoItem);
    // final TodoModel _todoItem = await this._service.add(id: _todo.length.toString(), todo: todo, isCheck: isCheck);
    // this._todo.add(_todoItem);
    // this.notifyListeners();
    // return _todoItem.copy(); // 참조를 끊어낸다.

    return Future<TodoModel>(() async {
      final TodoModel _todoItem = await this._service.add(id: _todo.length.toString(), todo: todo, isCheck: isCheck);
      this._todo.add(_todoItem);
      this.notifyListeners();
      return _todoItem.copy(); // 참조를 끊어낸다.
    });

  }

  TodoModel? _selectedTodoModel;
  TodoModel? get selectTodoModel => this._selectedTodoModel?.copy();

  /// .select = index;
  /// select(index); 더좋음.
  void select(int index){
    this._selectedTodoModel = this.todo[index];
    this.notifyListeners();
  }

  TodoModel update({required String id, required String todo, bool isCheck=false}){
    final TodoModel _updateTodo = TodoModel(id: id, todo: todo, isCheck: isCheck);
    /// List -> Map
    ///this._todo[id] = _updateTodo;
    for(int i = 0; i< this._todo.length; i++){
      if(this._todo[i].id == id){
        this._todo[i] = _updateTodo;
        break;
      }
    }
    this._selectedTodoModel = _updateTodo.copy(); // 여기서 작업
    this.notifyListeners();
    return _updateTodo.copy();
  }

  TodoModel? remove(String id){
    TodoModel? _removeTodo;
    for(int i = 0; i< this._todo.length; i++){
      if(this._todo[i].id == id){
        _removeTodo = this._todo[i].copy();
        this._todo.removeAt(i);
        break;
      }
    }
    this.notifyListeners();
    return _removeTodo;
  }

}
