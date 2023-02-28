import 'package:flutter/material.dart';
import 'dart:async';
import 'package:jjs/model/model.dart';
import 'package:jjs/myprovider.dart';
import 'package:jjs/sample/sample_provider.dart';
import 'package:jjs/sample/sample_view.dart';
import 'package:jjs/todo/provider/todo_provider.dart';
import 'package:jjs/todo/view/todoPage.dart';
import 'package:jjs/todo/view/todo_update_page.dart';

import 'package:provider/provider.dart';

//DI 의존성주입

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MyState>(
          create: (context) => MyState(), //한번만 동작한다.
        ),
        ChangeNotifierProvider<SampleProvider>(
          create: (context) => SampleProvider(),
        ),
        ChangeNotifierProvider<TodoProvider>(
          create: (context) => TodoProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //push를 할때 뒤에 named를 쓸거다.
        //어떤 경로에 따라서 어떤 애니매이션과 어떤 화면을 보여준다를 결정해줄수있다.
        onGenerateRoute: (RouteSettings routeSettings) {
          if (routeSettings.name == SampleDetailPage.path) {
            return MaterialPageRoute(
              settings: RouteSettings(name: SampleDetailPage.path),
              builder: (_) => SampleDetailPage(),
            );
          }
          if (routeSettings.name == SampleListPage.path) {
            return MaterialPageRoute(
              settings: RouteSettings(name: SampleListPage.path),
              builder: (_) => SampleListPage(),
            );
          }
          // return MaterialPageRoute(
          //   settings: RouteSettings(name: SampleViewPage.path),
          //   builder: (_) => SampleViewPage(),
          // );
          if (routeSettings.name == TodoUpdatePage.path) {
            return MaterialPageRoute(
              settings: RouteSettings(name: TodoUpdatePage.path),
              builder: (_) => TodoUpdatePage(),
            );
          }
          return MaterialPageRoute(
            settings: RouteSettings(name: TodoPage.path),
            builder: (_) => TodoPage(),
          );
        },

        // home: SampleViewPage(),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  // final T data;
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageView();
  }
}

class MainPageView extends StatelessWidget {
  MainPageView({Key? key}) : super(key: key);

  final _dumy = [
    {
      'img': '',
      'title': 'EDM',
      'des': [
        {
          'img': '',
          'name': '가수1',
          'desc': '정보...',
        },
        //
        //   'img': '',
        //   'name': '',
        //   'desc': '',
        // },
        // {
        //   'img': '',
        //   'name': '',
        //   'desc': '',
        // }
      ],
    },
    // {
    //   'img': '',
    //   'title': '',
    // },
    // {
    //   'img': '',
    //   'title': '',
    // },
  ];

  List<Data<DesData>> parser(List dumy) {
    //List <Map> -> data
    //맵은 불가능
    // final List<Data>_data = dumy.map<Data>((e) => Data(title: e['title'].toString(),
    //  des: List.of(e['des']) // 타입캐스팅 가능
    // .map<DesData>((j) => DesData(
    //  img: j['img'].toString(), name: j['name'], desc: j['desc'],),).toList(),
    //  img: e['img'].toString(),),).toList();

    final List<Data<DesData>> _data = dumy
        .map<Data<DesData>>((e) => Data<DesData>.fromJson(
            e,
            (List list) =>
                list.map<DesData>((t) => DesData.fromJson(t)).toList()))
        .toList();

    return _data;
  }

  @override
  Widget build(BuildContext context) {
    final List<Data<DesData>> _data = this.parser(_dumy);

    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          //제어의 역전을 위해서 build
          return MyCell(
            title: _data[index].title,
            onTap: () async {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => ListPage(),
              //   ),
              // );
              //Future -> pop()
              // int i = await Navigator.of(context).push<int?>(
              //   MaterialPageRoute(
              //     builder: (_) => ListPage(),
              //   ),
              // ) ?? 0;
              // print(i);
              int? i = await Navigator.of(context).push<int?>(
                MaterialPageRoute(
                  builder: (_) => ListPage(),
                ),
              );
              print(i);
              //<>은 nullable 반환값받고싶으면 await
              // bool? b = await showDialog<bool?>(
              //    context: context,
              //    builder: (BuildContext context) => AlertDialog(
              //      title: Text('POPUP'),
              //      actions: [
              //        TextButton(
              //          onPressed: () {
              //            Navigator.of(context).pop<bool>(false);
              //          },
              //          child: Text('취소'),
              //        ),
              //        TextButton(
              //          onPressed: () {
              //            Navigator.of(context).pop<bool>(true);
              //          },
              //          child: Text('확인'),
              //        ),
              //      ],
              //    ),
              //  );
              // print(b);
              // //null이나 넘겨진 값들의 처리
              // if(b == null){
              //
              // }
            },
            isShow: index % 2 == 0,
            // isShow:(){},
          );
        },
        itemCount: _data.length,
      ),
    );
  }
}
// Future.microtask > 가장 먼저 실행되는 루프! / 그다음 퓨쳐들의 루프가 실행된다.
// 왜? 동기적으로 하고싶은데 일반함수에넣으면 일반함수의 양이 많아진다.
// 싱글쓰레드 >> 쓸수있는 양이 정해져있다.

class MyCell extends StatelessWidget {
  //int : 받은 수가 홀짝인지 결정해서 ui를 그린다. -> 역할 추가
  //bool : t / f ->  역할이라고 보기는 어렵다.
  final bool isShow; // 변수와 함수의 차이?????
  final String title;
  final void Function()? onTap;

  const MyCell(
      {required this.title, required this.isShow, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(),
            boxShadow: [
              BoxShadow(color: Colors.grey.shade200, offset: Offset(1, 2)),
              BoxShadow(color: Colors.grey.shade200, offset: Offset(2, 1)),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(Icons.more_horiz),
              // width: (MediaQuery.of(context).size.width * 0.5)-15.0,
              // width: double.infinity,
              alignment: Alignment.centerRight,
            ),
            Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(color: Colors.grey, offset: Offset(1, 2)),
                      BoxShadow(color: Colors.grey, offset: Offset(2, 1)),
                    ],
                    borderRadius: BorderRadius.circular(50.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          'https://ssl.pstatic.net/melona/libs/1421/1421692/d21d11fe2c890e2d9723_20230117171110324.jpg'),
                    ),
                  ),
                ),
                // Container(
                //   width: 20.0,
                //   height: 20.0,
                //   color: Colors.red,
                // ),
                // Container(
                //   width: 10.0,
                //   height: 10.0,
                //   color: Colors.blue,
                // ),
                Positioned(
                  top: 2.0,
                  right: 2.0,
                  child: this.isShow
                      ? Container(
                          width: 15.0,
                          height: 15.0,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
            Container(
              child: Text(this.title),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.person),
                  Icon(Icons.mail_outline),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemBuilder: (context, int index) => ListTile(
          title: Text(
            index.toString(),
          ), //파라미터의 값으로 놓겟다 pop<int?>의 의미!!!
          // onTap: () => Navigator.of(context).pop<int>(index),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => DetailPage(),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      // endDrawer: Drawer(),//오른쪽으로
      appBar: AppBar(
          // leading:Container(),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.play_arrow),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://ssl.pstatic.net/melona/libs/1432/1432722/103266b5bfd9770b419c_20230120150040883.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight, //이미지 조정시에 사용하자
                ),
              ),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Text(
              'TITLE',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 60.0,
            ),
            Expanded(
              child: SingleChildScrollView(
                //밑에만 스크롤되는상태가괸다.
                child: Container(
                  child: Text(
                    'asdfffffffffffffffffffffdafsssssssssssdfssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssasdffffffffffasfddddddd',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
