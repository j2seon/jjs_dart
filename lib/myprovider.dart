import 'package:flutter/foundation.dart';

//상태만 관리 -> 목적만 생각하자
//증가
class MyState with ChangeNotifier{
  //주상태
  int v = 0;

  void add(){
    this. v +=1;
    this.notifyListeners(); // 변화를 알려준다.
    return;
  }
}