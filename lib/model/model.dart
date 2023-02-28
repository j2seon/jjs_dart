class Data<T> {
  final String img;
  final String title;
  final List<T> des;

  const Data({required this.title, required this.des, required this.img});

  Data.fromJson(e, List<T> Function(List) fun)
      : img = e['img'].toString(),
        title = e['title'].toString(),
        des = fun(List.of(e['des']));

  // static Data copy(Data data){
  //   return Data(title: ,des: ,img: );
  // }
  //
}


class DesData {
  final String img;
  final String name;
  final String desc;
  final String title;

  const DesData(
      {required this.img,
      required this.name,
      required this.desc,
      required this.title});

  DesData.fromJson(t)
      : img = t['img'].toString(),
        name = t['name'].toString(),
        desc = t['desc'].toString(),
        title = t['title'].toString();
}


