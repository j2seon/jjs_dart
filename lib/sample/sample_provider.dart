import 'package:flutter/foundation.dart';

import '../model/model.dart';

//포로바이더
class SampleProvider with ChangeNotifier {


  //캡슐화와 은닉화는 최대한 하는게 좋다.
  final List<Data<DesData>> _datas = [
    Data<DesData>.fromJson(
      {
        "img": "img",
        "title": "title",
        'des': [
          {
            "img": "https://ssl.pstatic.net/melona/libs/1432/1432722/103266b5bfd9770b419c_20230120150040883.jpg",
            "title": "제목",
            'name': '이름',
            "desc": '설명',
          }
        ]
      },
      (p0) => p0.map((e) => DesData.fromJson(e)).toList(),
    ),
  ];


  List<Data<DesData>> get datas => [...this._datas];

  ///필요하다면 매개변수 및 로직을 넣어준다. >> 나중에
  setData() {}

  int? _selectIndex;
  //반환하는 값이 필요할까? 그걸 고민하자
  ///int get selectIndex =>
  void setSelectIndex(int index){
    if(this._selectIndex == index) return;
    this._selectIndex = index;
    this.notifyListeners(); //상태이기 때문에 변경이되면 무조건 넣어주자
  }

  // String? get selectTitle{
  //   ///...
  //   if(this._selectIndex == null) return null;
  //   this._datas[this._selectIndex!].title ;
  // }

  Data<DesData>? get selectData{
    if(this._selectIndex == null) return null;
    return this._datas[this._selectIndex!];
  }

  int? _selectDetailIndex;

  void setDesIndex(int index){
    if(this._selectDetailIndex == index) return;
    this._selectDetailIndex = index;
    notifyListeners();
  }

  DesData? get selectDesData{
    if(this._selectDetailIndex == null) return null;
    return this.selectData!.des[this._selectDetailIndex!];
  }



}
